//
//  UIColor.swift
//  SwiftExtension
//
//  Created by Torghast on 3/3/21.
//

import UIKit

public extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }

  convenience init(red: Int, green: Int, blue: Int, alpha: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    assert(alpha >= 0 && blue <= 255, "Invalid alpha component")
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
  }

  convenience init(rgb: Int) {
    self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF)
  }

  convenience init(rgba: Int) {
    self.init(red: Int((rgba >> 24) & 0xFF), green: Int((rgba >> 16) & 0xFF), blue: Int((rgba >> 8) & 0xFF), alpha: Int(rgba & 0xFF))
  }

  @available(iOS 10.0, *)
  class func randomColor() -> UIColor {
    UIColor(displayP3Red: CGFloat.random(in: 0..<1), green: CGFloat.random(in: 0..<1), blue: CGFloat.random(in: 0..<1), alpha: 1)
  }
}
