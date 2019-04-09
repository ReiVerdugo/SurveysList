//
//  PageControllerDataSource.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/9/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

class PageControllerDataSource: NSObject {
  var pages: [SurveyCardViewController] = []
  
  init(items: [SurveyCardViewController]) {
    self.pages = items
  }
}

extension PageControllerDataSource: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = (viewController as? SurveyCardViewController)?.pageIndex,
      index > 0 else {
        return nil
    }
    return pages[index-1]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = (viewController as? SurveyCardViewController)?.pageIndex,
      index < pages.count-1 else {
        return nil
    }
    return pages[index+1]
  }
}
