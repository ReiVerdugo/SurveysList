//
//  SurveyDetailController.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/13/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

class SurveyDetailController: UIViewController {
  // MARK: Properties
  var surveyViewModel: SurveyViewModel?
  
  // MARK: Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationBar(with: surveyViewModel?.name ?? "")
  }
}
