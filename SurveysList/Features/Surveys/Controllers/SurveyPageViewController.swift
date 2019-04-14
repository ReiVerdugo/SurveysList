//
//  SurveyPageViewController.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

class SurveyPageViewController: UIPageViewController {
  
  // MARK: Properties
  var pageDataSource: PageControllerDataSource!
  lazy var pageControl = VerticalPageControl()
  var currentPage = 1 // The current page requested on server
  var currentSurvey = 0 // Current survey displayed
  var hasReachedEnd = false // Tells if there are no more surveys available from server
  let perPage = K.perPage // Number of items to request from server
  var surveyService: SurveyServiceProtocol = SurveyService()
  var authService: AuthenticationServiceProtocol = AuthenticationService()
  
  // MARK: Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    authService.renewToken() { [weak self] in
      self?.getSurveys()
    }
  }
  
  // MARK: Class methods
  func setupView() {
    pageDataSource = PageControllerDataSource(items: [])
    dataSource = pageDataSource
    delegate = self
    view.addSubview(pageControl)
    pageControl.setupConstraints()
    setNavigationBar(with: "Surveys".uppercased())
    setLeftBarButton()
  }
  
  func getSurveys() {
    if hasReachedEnd { return }
    let loadingIndicator = startProgressIndicator()
    surveyService.getSurveys(page: currentPage, perPage: perPage)
    { [weak self] surveys in
      guard let strongSelf = self else { return }
      strongSelf.populatePages(with: surveys)
      if surveys.count == strongSelf.perPage {
        strongSelf.currentPage += 1
      } else {
        strongSelf.hasReachedEnd = true
      }
      strongSelf.stopProgressIndicator(loadingIndicator)
    }
  }
  
  @objc func refreshSurveys() {
    pageDataSource.pages.removeAll()
    currentPage = 1
    currentSurvey = 0
    getSurveys()
  }
  
  func setLeftBarButton() {
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshSurveys))
    refresh.tintColor = .white
    navigationItem.leftBarButtonItem = refresh
  }
  
  func populatePages(with surveys: [Survey]) {
    for survey in surveys {
      guard let surveyController = storyboard?
        .instantiateViewController(withIdentifier: K.ViewControllers.surveyView.rawValue)
        as? SurveyCardViewController else { continue }
      let viewModel = SurveyViewModel(with: survey, index: pageDataSource.pages.count)
      surveyController.viewModel = viewModel
      pageDataSource.pages.append(surveyController)
    }
    setCurrentPage()
    pageControl.setNumberOfPages(pageDataSource.pages.count)
  }
  
  private func setCurrentPage() {
    let numberOfTotalPages = pageDataSource.pages.count
    guard currentSurvey < numberOfTotalPages else { return }
    let controller = pageDataSource.pages[currentSurvey]
      setViewControllers([controller],
                         direction: .forward,
                         animated: false,
                         completion: nil)
    pageControl.setCurrentPage(currentSurvey, totalNumberOfPages: numberOfTotalPages)
  }
}


// MARK: - UIPageViewControllerDelegate
extension SurveyPageViewController: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    if finished && completed,
      let viewController = pageViewController.viewControllers?.first as? SurveyCardViewController,
      let index = viewController.pageIndex {
      pageControl.setCurrentPage(index, totalNumberOfPages: pageDataSource.pages.count)
      currentSurvey = index
      if index == pageDataSource.pages.count - 1 {
        getSurveys()
      }
    }
  }
}

