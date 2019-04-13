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
  /// Performs a request to API
  ///
  /// - Parameters:
  ///   - method: HTTP method of the request
  ///   - urlString: path of the API's url
  ///   - parameters: Parameters of the request
  ///   - completion: completion block to run after request finished
  func request<T: Decodable>(_ method: Alamofire.HTTPMethod,
                             urlString: String,
                             parameters: Parameters?,
                             completion: @escaping (_ success: Result<T>) -> Void)
  
  /// Refreshes the token used on the authentication of the API
  ///
  /// - Parameters:
  ///   - urlString: path of the authentication service
  ///   - completion: Completion block to run after authentication method has finished
  func refreshToken(urlString: String, completion: @escaping (_ success: Result<Token>) -> Void)
}

class BaseService: BaseServiceProtocol {
  let baseUrl = "https://nimble-survey-api.herokuapp.com/"
  let defaultToken = "d9584af77d8c0d6622e2b3c554ed520b2ae64ba0721e52daa12d6eaa5e5cdd93"
  var token: String {
    return UserDefaults.standard.string(forKey: "token") ?? defaultToken
  }
  
  func refreshToken(urlString: String, completion: @escaping (_ success: Result<Token>) -> Void) {
    let url = baseUrl + urlString
    var request = try! URLRequest(url: url, method: .post)
    let bodyStr = "grant_type=password&username=carlos@nimbl3.com&password=antikera"
    request.httpBody = bodyStr.data(using: String.Encoding.utf8)
    
    Alamofire.request(request).responseJSON { response in
      let decoder = JSONDecoder()
      if response.result.isSuccess,
        let data = response.data,
        let token = try? decoder.decode(Token.self, from: data) {
          completion(Result<Token>.success(token))
      } else {
        
      }
    }
  }
  
  func request<T: Decodable>(_ method: Alamofire.HTTPMethod,
                             urlString: String,
                             parameters: Parameters? = nil,
                             completion: @escaping (_ success: Result<T>) -> Void) {
    let url = baseUrl + urlString
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    Alamofire.request(url, method: method, parameters: parameters, headers: headers)
      .responseJSON { response in
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
