//
//  UIViewController.swift
//  SwiftExtension
//
//  Created by Moon on 11/23/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Get is modal viewController
    public var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
}
