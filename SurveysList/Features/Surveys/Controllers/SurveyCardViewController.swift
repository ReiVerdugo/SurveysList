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

  // MARK: Properties
  @IBOutlet weak var titleLabel: UILabel?
  @IBOutlet weak var descriptionLabel: UILabel?
  @IBOutlet weak var surveyButton: RoundedButton?
  @IBOutlet weak var coverImage: UIImageView?
  var pageIndex: Int?
  var viewModel: SurveyViewModel?
  
  // MARK: Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    if let viewModel = viewModel {
      configureView(with: viewModel)
    }
    setColors()
  }
  
  // MARK: Class methods
  func configureView(with viewModel: SurveyViewModel) {
    titleLabel?.text = viewModel.name
    descriptionLabel?.text = viewModel.description
    coverImage?.sd_setImage(with: viewModel.coverImageUrl)
    pageIndex = viewModel.index
  }
  
  private func setColors() {
    surveyButton?.backgroundColor = .red1
    surveyButton?.setTitleColor(.white, for: .normal)
    titleLabel?.textColor = .white
    descriptionLabel?.textColor = .white
  }
  
  // MARK: Actions
  @IBAction func takeTheSurveyTapped(_ sender: Any) {
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "surveyDetailVC") as! SurveyDetailController 
    viewController.surveyViewModel = viewModel
      navigationController?.pushViewController(viewController, animated: true)
  }
  

}
