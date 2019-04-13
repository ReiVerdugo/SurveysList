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
  var currentPage = 1
  let perPage = 5
  
  // MARK: Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    let authenticationService = AuthenticationService()
    authenticationService.renewToken() { [weak self] in
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
    let service = SurveyService()
    service.getSurveys(page: currentPage, perPage: perPage)
    { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let surveys):
        strongSelf.populatePages(with: surveys)
        if surveys.count == strongSelf.perPage {
          strongSelf.currentPage += 1
        }
      case .failure:
        break
      }
    }
  }
  
  @objc func refreshSurveys() {
    pageDataSource.pages.removeAll()
    currentPage = 1
    pageControl.currentPage = 0
    getSurveys()
  }
  
  func setLeftBarButton() {
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshSurveys))
    refresh.tintColor = .white
    navigationItem.leftBarButtonItem = refresh
  }
  
  func populatePages(with surveys: [Survey]) {
    for survey in surveys {
      guard let surveyController = storyboard?.instantiateViewController(withIdentifier: "surveyView") as? SurveyCardViewController else { continue }
      let viewModel = SurveyViewModel(with: survey, index: pageDataSource.pages.count)
      surveyController.viewModel = viewModel
      pageDataSource.pages.append(surveyController)
    }
    setCurrentPage()
    pageControl.setNumberOfPages(pageDataSource.pages.count)
  }
  
  private func setCurrentPage() {
    guard pageControl.currentPage < pageDataSource.pages.count else { return }
    let controller = pageDataSource.pages[pageControl.currentPage]
      setViewControllers([controller],
                         direction: .forward,
                         animated: false,
                         completion: nil)
  }
}

extension SurveyPageViewController: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    if finished && completed,
      let viewController = pageViewController.viewControllers?.first as? SurveyCardViewController,
      let index = viewController.pageIndex {
      pageControl.currentPage = index
      if index == pageDataSource.pages.count - 1 {
        getSurveys()
      }
    }
  }
}

