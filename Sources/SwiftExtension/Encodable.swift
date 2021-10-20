//
//  Encodable.swift
//  SwiftExtension
//
//  Created by Torghast on 3/3/21.
//

import Foundation

public extension Encodable {
  subscript(key: String) -> Any? {
    dictionary[key]
  }

  var dictionary: [String: Any] {
    (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
  }

  /// 将模型编码
  /// - Returns: 二进制数据
  func Encode() -> Data? {
    do {
      return try JSONEncoder().encode(self)
    } catch let EncodingError.invalidValue(_, context) {
      print("EncodingError.invalidValue:", context.debugDescription)
      print(context.codingPath)
    } catch {
      print("error: ", error)
    }
    return nil
  }
}
