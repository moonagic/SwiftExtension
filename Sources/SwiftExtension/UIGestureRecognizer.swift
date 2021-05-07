//
//  UIGestureRecognizer.swift
//  SwiftExtension
//
//  Created by Torghast on 5/7/21.
//

import Foundation
import UIKit

extension UIGestureRecognizer {
    public typealias GestureBlock = (Any) -> Void
    
    fileprivate struct RuntimeKey {
        static let GestureBlockKey = UnsafeRawPointer.init(bitPattern: "GestureBlockKey".hashValue)
    }
    
    public convenience init(actionBlock: @escaping GestureBlock) {
        self.init()
        addActionBlock(actionBlock)
        addTarget(self, action: #selector(invoke(_:)))
    }
    
    fileprivate func addActionBlock(_ block: GestureBlock?) {
        if (block != nil) {
            objc_setAssociatedObject(self, UIGestureRecognizer.RuntimeKey.GestureBlockKey!, block!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc fileprivate func invoke(_ sender: Any) {
        let block = objc_getAssociatedObject(self, UIGestureRecognizer.RuntimeKey.GestureBlockKey!) as? GestureBlock
        block?(sender)
    }
}
