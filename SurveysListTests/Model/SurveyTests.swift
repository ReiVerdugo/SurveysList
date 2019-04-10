//
//  SurveyTests.swift
//  SurveysListTests
//
//  Created by Reinaldo Verdugo on 4/10/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import XCTest
@testable import SurveysList

class SurveyTests: XCTestCase {
  
  var survey: Survey!
  
  override func setUp() {
    survey = Survey.fixture1()
  }
  
  func test_Init() {
    XCTAssertNotNil(survey)
    let expectedId = "d5de6a8f8f5f1cfe51bc"
    let expectedTitle = "Scarlett Bangkok"
    let expectedDescription = "We'd love ot hear from you!"
    let expectedCoverImageUrl = "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_"
    XCTAssertEqual(survey.id, expectedId)
    XCTAssertEqual(survey.title, expectedTitle)
    XCTAssertEqual(survey.description, expectedDescription)
    XCTAssertEqual(survey.coverImage, expectedCoverImageUrl)
  }
}
