//
//  SurveyPageViewControllerTests.swift
//  SurveysListTests
//
//  Created by Reinaldo Verdugo on 4/14/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import XCTest
@testable import SurveysList

class SurveyPageViewControllerTests: XCTestCase {

  var vc: SurveyPageViewController!
  
  override func setUp() {
    let storyboard = UIStoryboard(name: K.Storyboards.surveys.rawValue,
                                  bundle: nil)
    let navController = storyboard.instantiateInitialViewController() as! UINavigationController
    let stubService = SurveyServiceStub()
    let authServiceStub = AuthenticationServiceStub()
    vc = navController.viewControllers.first as? SurveyPageViewController
    vc.surveyService = stubService
    vc.authService = authServiceStub
    let _ = vc.view
  }
  
  func test_init() {
    XCTAssertNotNil(vc)
    let expectedTitle = "Surveys".uppercased()
    XCTAssertEqual(vc.navigationItem.title, expectedTitle)
    XCTAssertNotNil(vc.navigationItem.leftBarButtonItem)
    XCTAssertNotNil(vc.delegate)
  }
  
  func test_dataSource() {
    XCTAssertNotNil(vc.dataSource)
    let expectedNumberOfPages = 1
    XCTAssertEqual(vc.pageDataSource.pages.count, expectedNumberOfPages)
  }
  
  func test_pageControl() {
    XCTAssertNotNil(vc.pageControl)
    let expectedNumberOfPages = 1
    XCTAssertEqual(vc.pageControl.numberOfPages, expectedNumberOfPages)
    XCTAssertEqual(vc.pageControl.currentPage, 0)
  }

}
