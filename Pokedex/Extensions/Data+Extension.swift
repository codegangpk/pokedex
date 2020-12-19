//
//  Data+Extension.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        guard let data = string.data(using: .utf8) else { return }
        
        append(data)
    }
}

extension Data {
    var prettyPrintedJSON: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedJSON = String(data: data, encoding: .utf8) else { return nil }
        
        return prettyPrintedJSON
    }
}
