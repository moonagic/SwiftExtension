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

public extension UIImage {
  /// convert image to base64 string
  /// - Returns:
  func toBase64() -> String? {
    guard let imageData = jpegData(compressionQuality: 0.9) else { return nil }
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
    manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options, resultHandler: { result, _ in
      complate(result)
    })
  }
    
  /// Create UIImage with color
  /// - Parameters:
  ///   - color:
  ///   - size:
  /// - Returns:
  class func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
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
    
  /// 获取UIImage中存在的二维码
  /// - Returns: 二维码对应的数据数组
  func parseQR() -> [String] {
    guard let image = CIImage(image: self) else {
      return []
    }
    let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                              context: nil,
                              options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
    let features = detector?.features(in: image) ?? []
    return features.compactMap { feature in
      (feature as? CIQRCodeFeature)?.messageString
    }
  }
}
