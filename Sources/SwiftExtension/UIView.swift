//
//  File.swift
//
//
//  Created by Torghast on 7/26/21.
//

import UIKit

public extension UIView {
  func image() -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
    defer { UIGraphicsEndImageContext() }
    if let context = UIGraphicsGetCurrentContext() {
      layer.render(in: context)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      return image
    }
    return nil
  }
}
