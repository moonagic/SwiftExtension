//
//  UIViewController.swift
//  SwiftExtension
//
//  Created by Moon on 11/23/20.
//

import Foundation
import UIKit

@available(iOSApplicationExtension, unavailable)
extension UIViewController {
    
    /// Get is modal viewController
    public var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    public func topMostViewController() -> UIViewController? {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
    
    public class func topViewController(_ viewController: UIViewController? = nil) -> UIViewController? {
        let viewController = viewController ?? UIApplication.shared.keyWindow?.rootViewController

        if let navigationController = viewController as? UINavigationController,
            !navigationController.viewControllers.isEmpty {
            return self.topViewController(navigationController.viewControllers.last)

        } else if let tabBarController = viewController as? UITabBarController,
            let selectedController = tabBarController.selectedViewController {
            return self.topViewController(selectedController)

        } else if let presentedController = viewController?.presentedViewController {
            return self.topViewController(presentedController)
            
        }

        return viewController
    }
    
}
