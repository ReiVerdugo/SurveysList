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
    let pageControlSizeLimit = K.pageControlLimit
    let pageIndicator = app.pageIndicators.firstMatch
    let pageControlExists = pageIndicator.waitForExistence(timeout: 10)
    XCTAssert(pageControlExists)
    let perPage = K.perPage
    let pageOfRequest = perPage - 1
    for _ in 1...pageOfRequest {
      app.swipeUp()
    }
    sleep(5)
    // If the number of pages is less than the limit, it will keep as it is
    // Otherwise, the number of pages will be the limit
    let expectedNumberOfPages = (perPage * 2) <= pageControlSizeLimit
      ? perPage * 2 : pageControlSizeLimit
    
    // If the number of pages is less than the limit, it will keep as it is
    // Otherwise, we calculated dividing between the number of items per bullet
    let expectedCurrentPage = (perPage * 2) <= pageControlSizeLimit
      ? pageOfRequest
      : perPage/((perPage * 2)/pageControlSizeLimit)
    
    // We add 1 as the page values on UI test start from 1
    let expectedValue = "page \(expectedCurrentPage+1) of \(expectedNumberOfPages)"
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
    
    let expectedNumberOfPages = K.perPage <= K.pageControlLimit
      ? K.perPage : K.pageControlLimit
    let expectedValue = "page 1 of \(expectedNumberOfPages)"
    XCTAssertEqual(pageIndicator.value as? String, expectedValue)
  }
}
