//
//  ButtonExtension.swift
//  Client
//
//  Created by Moon on 11/20/20.
//

import UIKit

/// Add block target action with UIControl
public extension UIControl {
  /// Typealias for UIControl closure.
  typealias UIControlTargetClosure = (UIControl) -> ()
    
  private class UIControlClosureWrapper {
    let closure: UIControlTargetClosure
    init(_ closure: @escaping UIControlTargetClosure) {
      self.closure = closure
    }
  }
    
  private enum AssociatedKeys {
    static var targetClosure = "targetClosure"
  }
    
  private var targetClosure: UIControlTargetClosure? {
    get {
      guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else { return nil }
      return closureWrapper.closure
    }
    set(newValue) {
      guard let newValue = newValue else { return }
      objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIControlClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
    
  @objc func closureAction() {
    guard let targetClosure = targetClosure else { return }
    targetClosure(self)
  }
    
  func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
    targetClosure = closure
    addTarget(self, action: #selector(UIControl.closureAction), for: event)
  }
}
