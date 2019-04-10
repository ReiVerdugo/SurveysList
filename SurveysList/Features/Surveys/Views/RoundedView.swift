//
//  RoundedView.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/9/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    applyRoundedCorner(with: bounds.height/2)
  }
}
