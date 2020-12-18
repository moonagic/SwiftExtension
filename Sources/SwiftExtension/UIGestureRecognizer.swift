//
//  G.swift
//  SwiftExtension
//
//  Created by Moon on 11/25/20.
//

import Foundation
import UIKit


extension UIGestureRecognizer {
    public typealias MGGestureBlock = ((Any)->())
    
    public struct RuntimeKey {
        static let GestureBlockKey = UnsafeRawPointer.init(bitPattern: "GestureBlockKey".hashValue)
    }
    
    public convenience init(actionBlock: @escaping MGGestureBlock) {
        self.init()
        addActionBlock(actionBlock)
        addTarget(self, action: #selector(invoke(_:)))
    }
    
    public func addActionBlock(_ block: MGGestureBlock?) {
        if (block != nil) {
            objc_setAssociatedObject(self, UIGestureRecognizer.RuntimeKey.GestureBlockKey!, block!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc public func invoke(_ sender: Any) {
        let block = objc_getAssociatedObject(self, UIGestureRecognizer.RuntimeKey.GestureBlockKey!) as? MGGestureBlock
        if (block != nil) {
            block!(sender);
        }
    }
}
