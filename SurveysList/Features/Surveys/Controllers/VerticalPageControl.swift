//
//  VerticalPageControl.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/10/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

class VerticalPageControl: UIPageControl {
  // MARK: Properties
  let kPageControlWidth: CGFloat = 20
  let kPageControlRightMargin: CGFloat = 8
  let kPageControlHeight: CGFloat = 30
  let kSizeLimit = K.pageControlLimit

  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.6)
    isHidden = true
    isUserInteractionEnabled = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Class methods
  func setupConstraints() {
    let views = ["pageControl": self]
    let metrics = ["pageControlWidth": kPageControlWidth,
                   "pageControlRightMargin": kPageControlRightMargin,
                   "pageControlHeight": kPageControlHeight]
    var horizontalConstraints = NSLayoutConstraint.constraints(
      withVisualFormat: "H:[pageControl(pageControlWidth)]-pageControlRightMargin-|",
      options: [],
      metrics: metrics,
      views: views)
    let verticalConstriants = NSLayoutConstraint.constraints(
      withVisualFormat: "V:[pageControl(pageControlHeight)]",
      options: [],
      metrics: metrics,
      views: views)
    let centerConstraint = NSLayoutConstraint(
      item: self,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: superview,
      attribute: .centerY,
      multiplier: 1.0,
      constant: 0)
    horizontalConstraints.append(centerConstraint)
    NSLayoutConstraint.activate(horizontalConstraints + verticalConstriants)
    
    // Rotate page control to make it vertical
    let rotationTransform = CGAffineTransform(rotationAngle: .pi/2)
    // Move page control to right side
    let rightMarginSpace = CGFloat((kPageControlWidth/2) - kPageControlRightMargin)
    self.transform = rotationTransform.translatedBy(x: 0, y: -rightMarginSpace)
    isHidden = false
    currentPage = 0
  }
  
  /// If the number of pages is greater than the limit, use the limit
  /// Otherwise return the number of pages
  ///
  /// - Parameter number: number of pages
  func setNumberOfPages(_ number: Int) {
    numberOfPages = number <= kSizeLimit ? number : kSizeLimit
  }
  
  /// If the number of pages is greater than the limit, calculate the current page
  /// The current page will be the numberOfPage divided by the number of items per
  /// bullet
  /// If the number of pages is lower than the limit, assign as it is.
  ///
  /// - Parameters:
  ///   - number: the index of the page
  ///   - totalNumberOfPages: the total number of pages
  func setCurrentPage(_ number: Int, totalNumberOfPages: Int) {
    if totalNumberOfPages <= kSizeLimit {
      currentPage = number
    } else {
      let numElements = totalNumberOfPages/kSizeLimit
      currentPage = (number / numElements)
    }
  }
}
