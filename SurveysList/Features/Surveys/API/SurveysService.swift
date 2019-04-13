//
//  SurveysService.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Alamofire

protocol SurveyServiceProtocol: class {
  /// Requests the list of surveys, using page and perPage parameters if included
  ///
  /// - Parameters:
  ///   - page: number of the current page for request (pagination)
  ///   - perPage: number of elements to fetch on the request
  ///   - completion: Completion block to execute after the request finished
  func getSurveys(page: Int?, perPage: Int?, completion: @escaping (_ success: Result<[Survey]>) -> Void)
}

class SurveyService: BaseService, SurveyServiceProtocol {
  func getSurveys(page: Int? = nil, perPage: Int? = nil, completion: @escaping (_ success: Result<[Survey]>) -> Void) {
    var parameters: [String: AnyObject] = [:]
    if let page = page {
      parameters["page"] = page as AnyObject
    }
    if let perPage = perPage {
      parameters["per_page"] = perPage as AnyObject
    }
    request(HTTPMethod.get, urlString: "surveys.json", parameters: parameters, completion: completion)
  }
}

