//
//  Token.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/11/19.
//  Copyright © 2019 Nimble. All rights reserved.
//


struct Token: Codable {
  var accessToken: String
  var tokenType: String
  
  private enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
  }
  
}
