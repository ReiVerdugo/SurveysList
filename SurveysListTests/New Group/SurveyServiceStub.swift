//
//  SurveyServiceStub.swift
//  SurveysListTests
//
//  Created by Reinaldo Verdugo on 4/14/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

@testable import SurveysList

class SurveyServiceStub: SurveyServiceProtocol {
  func getSurveys(page: Int?, perPage: Int?, completion: @escaping ([Survey]) -> Void) {
    let survey = Survey.fixture1()
    completion([survey])
  }
}

class AuthenticationServiceStub: AuthenticationServiceProtocol {
  func renewToken(completion: @escaping ()->()) {
    completion()
  }
}
