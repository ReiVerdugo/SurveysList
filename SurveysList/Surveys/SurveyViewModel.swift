//
//  SurveyViewModel.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Foundation

struct SurveyViewModel {
  let name: String
  let description: String
  let coverImageUrl: URL?
  let index: Int
  
  init(with survey: Survey, index: Int) {
    self.name = survey.title
    self.description = survey.description
    self.index = index
    coverImageUrl = URL(string: "\(survey.coverImage)l")
  }
}
