//
//  VerticalPageControl.swift
//  SurveysList
//
//  Created by Reinaldo Verdugo on 4/10/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

class VerticalPageControl: UIPageControl {
  
  let kPageControlWidth: CGFloat = 20
  let kPageControlRightMargin: CGFloat = 8
  let kPageControlHeight: CGFloat = 30

  
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
  }
}
