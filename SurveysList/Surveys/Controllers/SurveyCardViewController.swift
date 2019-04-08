//
//  SurveyCardViewController.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit
import SDWebImage

class SurveyCardViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel?
  @IBOutlet weak var descriptionLabel: UILabel?
  @IBOutlet weak var surveyButton: UIButton?
  @IBOutlet weak var coverImage: UIImageView?
  var pageIndex: Int?
  var viewModel: SurveyViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let viewModel = viewModel {
      configureView(with: viewModel)
    }
  }
  
  func configureView(with viewModel: SurveyViewModel) {
    titleLabel?.text = viewModel.name
    descriptionLabel?.text = viewModel.description
    coverImage?.sd_setImage(with: viewModel.coverImageUrl)
    pageIndex = viewModel.index
  }

}
