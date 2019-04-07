//
//  BaseService.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseServiceProtocol {
  func request<T: Decodable>(_ method: Alamofire.HTTPMethod,
                             urlString: String,
                             parameters: [String: AnyObject]?,
                             completion: @escaping (_ success: Result<T>) -> Void)
}

class BaseService: BaseServiceProtocol {
  let baseUrl = "​https://rallycoding.herokuapp.com/api/music_albums"
  let headers: HTTPHeaders = [
    "Authorization": "Bearer d9584af77d8c0d6622e2b3c554ed520b2ae64ba0721e52daa12d6eaa5e5cdd93"
  ]
  func request<T: Decodable>(_ method: Alamofire.HTTPMethod,
                             urlString: String,
                             parameters: [String: AnyObject]? = nil,
                             completion: @escaping (_ success: Result<T>) -> Void) {

    
    Alamofire.request("https://nimble-survey-api.herokuapp.com/surveys.json", method: method, parameters: parameters, headers: headers).responseJSON { response in
        switch response.result {
        case .success:
          let decoder = JSONDecoder()
          guard let data = response.data,
            let value = try? decoder.decode(T.self, from: data) else {
            let error = NSError()
            completion(Result<T>.failure(error))
            return
          }
          let result: Result<T> = Result<T>.success(value)
          completion(result)
        case .failure(let error as NSError):
          debugPrint("error - >     \(error.localizedDescription) ")
          completion(Result<T>.failure(error))
        }
      }
  }
}
