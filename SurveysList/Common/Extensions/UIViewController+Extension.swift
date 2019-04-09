//
//  UIViewController+Extension.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/9/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

extension UIViewController {
  func setNavigationBar(with title: String) {
    navigationItem.title = title
    navigationController?.navigationBar.barTintColor = .darkBlue1
    navigationController?.navigationBar.tintColor = .darkBlue1
    navigationController?.navigationBar.barStyle = .blackOpaque
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
}
