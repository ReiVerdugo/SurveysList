//
//  SurveyViewModelTests.swift
//  SurveysListTests
//
//  Created by Reinaldo Verdugo on 4/10/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import XCTest
@testable import SurveysList

class SurveyViewModelTests: XCTestCase {

  var viewModel: SurveyViewModel!
  
  override func setUp() {
    let survey = Survey.fixture1()
    viewModel = SurveyViewModel(with: survey, index: 0)
  }

  func test_init() {
    XCTAssertNotNil(viewModel)
    XCTAssertNotNil(viewModel.coverImageUrl)
    let expectedDescription = "We'd love ot hear from you!"
    let expectedName = "Scarlett Bangkok"
    XCTAssertEqual(viewModel.name, expectedName)
    XCTAssertEqual(viewModel.description, expectedDescription)
  }

}
