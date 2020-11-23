//
//  UIImage.swift
//  Client
//
//  Created by Moon on 11/23/20.
//  Copyright © 2020 跃医通科技. All rights reserved.
//

import Foundation
import Photos
import UIKit

extension UIImage {
    
    /// convert image to base64 string
    /// - Returns:
    open func toBase64() -> String? {
        guard let imageData = self.jpegData(compressionQuality: 0.9) else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    /// fetch image with PHAsset
    /// - Parameters:
    ///   - asset:
    ///   - complate: 
    open class func fetchFrom(asset: PHAsset, complate: @escaping (UIImage?) -> Void) {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.resizeMode = .none
        options.deliveryMode = .highQualityFormat
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options, resultHandler: { (result, info) in
            complate(result)
        })
    }
    
    /// Create UIImage with color
    /// - Parameters:
    ///   - color:
    ///   - size:
    /// - Returns:
    open class func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }

    
}
