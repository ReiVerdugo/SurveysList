//
//  Survey+Fixtures.swift
//  SurveysListTests
//
//  Created by Reinaldo Verdugo on 4/10/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Foundation
@testable import SurveysList

extension Survey {
  static func fixture1() -> Survey {
    let json = DataLoader.loadJson(fileName: "Survey1")
    return Survey(from: json)
  }
}
