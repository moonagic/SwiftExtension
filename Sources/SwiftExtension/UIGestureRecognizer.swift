//
//  G.swift
//  SwiftExtension
//
//  Created by Moon on 11/25/20.
//

import Foundation
import UIKit


extension UIGestureRecognizer {
    typealias MGGestureBlock = ((Any)->())
    
    fileprivate struct RuntimeKey {
        static let GestureBlockKey = UnsafeRawPointer.init(bitPattern: "GestureBlockKey".hashValue)
    }
    
    convenience init(actionBlock: @escaping MGGestureBlock) {
        self.init()
        addActionBlock(actionBlock)
        addTarget(self, action: #selector(invoke(_:)))
    }
    
    fileprivate func addActionBlock(_ block: MGGestureBlock?) {
        if (block != nil) {
            objc_setAssociatedObject(self, UIGestureRecognizer.RuntimeKey.GestureBlockKey!, block!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc fileprivate func invoke(_ sender: Any) {
        let block = objc_getAssociatedObject(self, UIGestureRecognizer.RuntimeKey.GestureBlockKey!) as? MGGestureBlock
        if (block != nil) {
            block!(sender);
        }
    }
}
