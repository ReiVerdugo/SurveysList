//
//  AuthenticationService.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/11/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Foundation

protocol AuthenticationServiceProtocol: class {
  func renewToken(completion: @escaping ()->())
}

class AuthenticationService: BaseService, AuthenticationServiceProtocol {
  func renewToken(completion: @escaping ()->()) {
    refreshToken(urlString: "oauth/token") { response in
      switch response {
      case .success(let token):
        UserDefaults.standard.set(token.accessToken, forKey: "token")
        completion()
      case .failure:
        break
      }
    }
  }
}
