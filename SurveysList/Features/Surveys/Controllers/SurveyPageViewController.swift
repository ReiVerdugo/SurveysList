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
  var surveys: [Survey] = []
  var pageDataSource: PageControllerDataSource?
  lazy var pageControl = VerticalPageControl()
  
  // MARK: Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    getSurveys()
  }
  
  // MARK: Class methods
  func setupView() {
    pageDataSource = PageControllerDataSource(items: [])
    dataSource = pageDataSource
    delegate = self
    view.addSubview(pageControl)
    pageControl.setupConstraints()
    setNavigationBar(with: "Surveys".uppercased())
  }
  
  func getSurveys() {
    let service = SurveyService()
    service.getSurveys { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let surveys):
        strongSelf.surveys = surveys
        strongSelf.populatePages()
      case .failure:
        break
      }
    }
  }
  
  func populatePages() {
    for (index, survey) in surveys.enumerated() {
      guard let surveyController = storyboard?.instantiateViewController(withIdentifier: "surveyView") as? SurveyCardViewController else { continue }
      let viewModel = SurveyViewModel(with: survey, index: index)
      surveyController.viewModel = viewModel
      pageDataSource?.pages.append(surveyController)
    }
    moveToFirstPage()
    setupPageControl()
  }
  
  func setupPageControl() {
    guard let pages = pageDataSource?.pages else { return }
    pageControl.numberOfPages = pages.count
    pageControl.currentPage = 0
    pageControl.isHidden = false
  }
  
  
  
  private func moveToFirstPage() {
    if let firstController = pageDataSource?.pages.first {
      setViewControllers([firstController],
                         direction: .forward,
                         animated: false,
                         completion: nil)
    }
  }
}

extension SurveyPageViewController: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    if finished && completed,
      let viewController = pageViewController.viewControllers?.first as? SurveyCardViewController,
      let index = viewController.pageIndex {
      pageControl.currentPage = index
    }
  }
}

