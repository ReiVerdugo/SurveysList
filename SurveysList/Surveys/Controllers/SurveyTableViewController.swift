//
//  SurveyTableViewController.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

class SurveyTableViewController: UIViewController {

  var surveys: [Survey] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getSurveys()
  }
  
  func getSurveys() {
    let service = SurveyService()
    service.getSurveys { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let surveys):
        strongSelf.surveys = surveys
      case .failure:
        break
      }
    }
  }
}
