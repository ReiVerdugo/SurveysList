//
//  AppDelegate.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/7/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Exit early if there are unit tests running
    if NSClassFromString("XCTestCase") != nil {
      return true
    }
    let storyboard = UIStoryboard(name: K.Storyboards.surveys.rawValue,
                                  bundle: nil)
    let surveysList = storyboard.instantiateInitialViewController()
    window?.rootViewController = surveysList
    return true
  }
}

