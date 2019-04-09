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
  
  let kPageControlWidth: CGFloat = 20
  let kPageControlRightMargin: CGFloat = 8
  let kPageControlHeight: CGFloat = 30
  
  lazy var pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.6)
    pageControl.isHidden = true
    pageControl.isUserInteractionEnabled = false
    return pageControl
  }()
  
  // MARK: Lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pageDataSource = PageControllerDataSource(items: [])
    dataSource = pageDataSource
    delegate = self
    setupPageControlConstraints()
    setNavigationBar(with: "Surveys".uppercased())
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
  
  func setupPageControlConstraints() {
    self.view.addSubview(pageControl)
    let views = ["pageControl": self.pageControl]
    let metrics = ["pageControlWidth": kPageControlWidth,
                   "pageControlRightMargin": kPageControlRightMargin,
                   "pageControlHeight": kPageControlHeight]
    var horizontalConstraints = NSLayoutConstraint.constraints(
      withVisualFormat: "H:[pageControl(pageControlWidth)]-pageControlRightMargin-|",
      options: [],
      metrics: metrics,
      views: views)
    let verticalConstriants = NSLayoutConstraint.constraints(
      withVisualFormat: "V:[pageControl(pageControlHeight)]",
      options: [],
      metrics: metrics,
      views: views)
    let centerConstraint = NSLayoutConstraint(
      item: self.pageControl,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: self.view,
      attribute: .centerY,
      multiplier: 1.0,
      constant: 0)
    horizontalConstraints.append(centerConstraint)
    NSLayoutConstraint.activate(horizontalConstraints + verticalConstriants)
    
    // Rotate page control to make it vertical
    let rotationTransform = CGAffineTransform(rotationAngle: .pi/2)
    // Move page control to right side
    let rightMarginSpace = CGFloat((kPageControlWidth/2) - kPageControlRightMargin)
    pageControl.transform = rotationTransform.translatedBy(x: 0, y: -rightMarginSpace)
    
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

