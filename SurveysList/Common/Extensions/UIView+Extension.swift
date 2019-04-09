//
//  UIView+Extension.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/9/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

extension UIView {
  func applyRoundedCorner(with value: CGFloat, width: CGFloat = 1.0) {
    layer.cornerRadius = value
    layer.masksToBounds = true
    layer.borderWidth = width
  }
}
