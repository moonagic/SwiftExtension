//
//  Encodable.swift
//  SwiftExtension
//
//  Created by Torghast on 3/3/21.
//

import Foundation

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    public var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
