//
//  RuntimeError.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

struct RuntimeError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    var localizedDescription: String {
        return message
    }
}
