//
//  SurveysService.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Alamofire

class SurveyService: BaseService {
  func getSurveys(completion: @escaping (_ success: Result<[Survey]>) -> Void) {
    request(HTTPMethod.get, urlString: "surveys.json", completion: completion)
  }
}

