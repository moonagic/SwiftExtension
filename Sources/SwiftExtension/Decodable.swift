//
//  File.swift
//  
//
//  Created by Torghast on 10/20/21.
//

import Foundation

public extension Decodable {
  /// 统一的decode方法
  /// - Parameter content: json
  /// - Returns: 对应的decodable对象
  public static func Decode(content: String?) -> Self? {
    guard let data = content?.data(using: .utf8) else { return nil }
    return Decode(data: data)
  }
  
  /// 统一的decode方法
  /// - Parameter data: data
  /// - Returns: 对应的decodable对象
  public static func Decode(data: Data) -> Self? {
    do {
      return try JSONDecoder().decode(self, from: data)
    } catch let DecodingError.dataCorrupted(context) {
      print(context)
    } catch let DecodingError.keyNotFound(key, context) {
      print("Key '\(key)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch let DecodingError.valueNotFound(value, context) {
      print("Value '\(value)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch let DecodingError.typeMismatch(type, context) {
      print("Type '\(type)' mismatch:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch {
      print("error: ", error)
    }
    return nil
  }
}
