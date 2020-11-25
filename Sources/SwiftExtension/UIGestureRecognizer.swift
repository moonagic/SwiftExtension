//
//  G.swift
//  SwiftExtension
//
//  Created by Moon on 11/25/20.
//

import Foundation
import UIKit

extension UIGestureRecognizer {
    
    /// Typealias for UIControl closure.
    public typealias UIGestureEventClosure = (UIGestureRecognizer) -> ()
    
    private class UIControlClosureWrapper {
        let closure: UIGestureEventClosure
        init(_ closure: @escaping UIGestureEventClosure) {
            self.closure = closure
        }
    }
    
    private struct AssociatedKeys {
        static var eventClosure = "eventClosure"
    }
    
    private var eventClosure: UIGestureEventClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.eventClosure) as? UIControlClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.eventClosure, UIControlClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func closureAction() {
        guard let eventClosure = eventClosure else { return }
        eventClosure(self)
    }
    
    
    open class func initWith(actionBlock: @escaping UIGestureEventClosure) -> UIGestureRecognizer {
        let ges = UIGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.closureAction))
        return ges
    }
    
}
