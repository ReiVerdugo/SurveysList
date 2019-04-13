//
//  SurveysListUITests.swift
//  SurveysListUITests
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import XCTest

class SurveysListUITests: XCTestCase {

  let app = XCUIApplication()
  
  override func setUp() {
    super.setUp()
    app.launch()
  }

  /// Tests that the page control is updated with every swipe
  func test_pageControlNumber() {
    let pageIndicator = app.pageIndicators.firstMatch
    let pageControlExists = pageIndicator.waitForExistence(timeout: 10)
    XCTAssert(pageControlExists)
    let expectedNumberOfPages = 5
    app.swipeUp()
    var expectedValue = "page 2 of \(expectedNumberOfPages)"
    XCTAssertEqual(pageIndicator.value as? String, expectedValue)
    
    app.swipeDown()
    expectedValue = "page 1 of \(expectedNumberOfPages)"
    XCTAssertEqual(pageIndicator.value as? String, expectedValue)
  }
  
  /// Tests that the navigation is done correctly by checking the title of the detail view
  func test_NavigationAfterTappingOnSurvey() {
    let surveyTitle = app.staticTexts["surveyTitle"]
    let titleExists = surveyTitle.waitForExistence(timeout: 10)
    XCTAssert(titleExists)
    
    let expectedTitle = surveyTitle.label
    app.buttons["takeSurveyButton"].tap()
    sleep(1)
    let navBarTitle = app.navigationBars.firstMatch.identifier
    XCTAssertEqual(expectedTitle, navBarTitle)
  }
  
  /// Tests that after swipping to the bottom of the pages, a new request is done
  func test_PaginationRequest() {
    let pageIndicator = app.pageIndicators.firstMatch
    let pageControlExists = pageIndicator.waitForExistence(timeout: 10)
    XCTAssert(pageControlExists)
    
    let numberOfPages = 5
    for _ in 1...numberOfPages-1 {
      app.swipeUp()
    }
    sleep(5)
    let expectedNumberOfPages = 10
    let expectedValue = "page \(numberOfPages) of \(expectedNumberOfPages)"
    XCTAssertEqual(pageIndicator.value as? String, expectedValue)
  }
  
  /// Tests that the refresh button resets the data source
  func test_refreshButton() {
    test_PaginationRequest() // Make request first to have more than 5 pages
    let refreshButton = app.navigationBars["SURVEYS"].buttons["Refresh"]
    refreshButton.tap()
    sleep(3)
    let pageIndicator = app.pageIndicators.firstMatch
    let pageControlExists = pageIndicator.waitForExistence(timeout: 10)
    XCTAssert(pageControlExists)
    
    let expectedNumberOfPages = 5
    let expectedValue = "page 1 of \(expectedNumberOfPages)"
    XCTAssertEqual(pageIndicator.value as? String, expectedValue)
  }
}
