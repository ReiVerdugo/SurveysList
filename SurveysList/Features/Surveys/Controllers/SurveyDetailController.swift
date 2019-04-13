//
//  SurveyDetailController.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/13/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

class SurveyDetailController: UIViewController {
  var surveyViewModel: SurveyViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationBar(with: surveyViewModel?.name ?? "")
  }
}
