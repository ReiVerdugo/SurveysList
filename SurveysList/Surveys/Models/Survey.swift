//
//  Survey.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Foundation

struct Survey: Codable {
  let id: String
  var title: String
  var description: String
  var coverImage: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case description
    case coverImage = "cover_image_url"
  }
}
