//
//  String.swift
//  SwiftExtension
//
//  Created by Moon on 11/23/20.
//

import CommonCrypto
import Foundation

public extension String {
  func isPhone() -> Bool {
    if self.isAllDigits() == true {
      return self.first == "1" && self.count == 11
    } else {
      return false
    }
  }
    
  func isAllDigits() -> Bool {
    let charcterSet = NSCharacterSet(charactersIn: "+0123456789").inverted
    let inputString = self.components(separatedBy: charcterSet)
    let filtered = inputString.joined(separator: "")
    return self == filtered
  }
    
  func isValiteemail() -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailTest.evaluate(with: self)
  }
    
  func isValiteIDNumber() -> Bool {
    let idRegex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
    let idTest = NSPredicate(format: "SELF MATCHES %@", idRegex)
    return idTest.evaluate(with: self)
  }
    
  /// 获取指定长度随机字符串
  ///
  /// - Parameter length: 长度
  /// - Returns: 目标字符串
  static func GetRandomStringOfLength(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in letters.randomElement()! })
  }
    
  static func GetRandomNumberOfLength(length: Int) -> String {
    let letters = "0123456789"
    return String((0..<length).map { _ in letters.randomElement()! })
  }
    
  static func uuid() -> String {
    UUID().uuidString.replacingOccurrences(of: "-", with: "")
  }
    
  var asciiArray: [UInt32] {
    unicodeScalars.filter(\.isASCII).map(\.value)
  }
    
  // this is our hashCode function, which produces equal output to the Java or Android hash function
  func hashCode() -> Int32 {
    var h: Int32 = 0
    for i in self.asciiArray {
      h = 31 &* h &+ Int32(i) // Be aware of overflow operators,
    }
    return h
  }
    
  func aabb() -> String {
    "aabb"
  }
}
