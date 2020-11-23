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
    func toBase64() -> String? {
        guard let imageData = self.jpegData(compressionQuality: 0.9) else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    /// fetch image with PHAsset
    /// - Parameters:
    ///   - asset:
    ///   - complate: 
    class func fetchFrom(asset: PHAsset, complate: @escaping (UIImage?) -> Void) {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.resizeMode = .none
        options.deliveryMode = .highQualityFormat
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options, resultHandler: { (result, info) in
            complate(result)
        })
    }
    
}
