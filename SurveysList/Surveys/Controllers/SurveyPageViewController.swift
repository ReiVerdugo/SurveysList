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
  var surveyPages: [SurveyCardViewController] = []
  
  // MARK: Lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dataSource = self
    getSurveys()
  }
  
  // MARK: Class methods
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
      surveyPages.append(surveyController)
    }
    if let firstController = surveyPages.first {
      setViewControllers([firstController],
                         direction: .forward,
                         animated: false,
                         completion: nil)
    }
  }
}

extension SurveyPageViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = (viewController as? SurveyCardViewController)?.pageIndex,
      index > 0 else {
        return nil
    }
    return surveyPages[index-1]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = (viewController as? SurveyCardViewController)?.pageIndex,
      index < surveyPages.count-1 else {
        return nil
    }
    return surveyPages[index+1]
  }
}
