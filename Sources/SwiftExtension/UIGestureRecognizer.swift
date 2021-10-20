//
//  UIGestureRecognizer.swift
//  SwiftExtension
//
//  Created by Torghast on 5/7/21.
//

import Foundation
import UIKit

public extension UIGestureRecognizer {
  typealias GestureBlock = (Any) -> Void
    
  fileprivate enum RuntimeKey {
    static let GestureBlockKey = UnsafeRawPointer(bitPattern: "GestureBlockKey".hashValue)
  }
    
  convenience init(actionBlock: @escaping GestureBlock) {
    self.init()
    addActionBlock(actionBlock)
    addTarget(self, action: #selector(invoke(_:)))
  }
    
  private func addActionBlock(_ block: GestureBlock?) {
    if block != nil {
      objc_setAssociatedObject(self, UIGestureRecognizer.RuntimeKey.GestureBlockKey!, block!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
    
  @objc private func invoke(_ sender: Any) {
    let block = objc_getAssociatedObject(self, UIGestureRecognizer.RuntimeKey.GestureBlockKey!) as? GestureBlock
    block?(sender)
  }
}
