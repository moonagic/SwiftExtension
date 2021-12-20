//
//  UIApplication.swift
//  SwiftExtension
//
//  Created by Torghast on 3/3/21.
//

import Foundation
import UIKit

@available(iOSApplicationExtension, unavailable)
public extension UIApplication {
  /// 获取keyWindow的兼容函数
  /// - Returns: keyWindow
  func getKeyWindow() -> UIWindow? {
    if #available(iOS 13, *) {
      return UIApplication
        .shared
        .connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .first?.windows.first {
          $0.isKeyWindow
        }
    } else {
      return self.keyWindow
    }
  }
}
