//
//  SurveysService.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Alamofire

class SurveyService: BaseService {
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

