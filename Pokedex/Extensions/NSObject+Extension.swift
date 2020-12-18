//
//  NSObject+Extension.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: self)
    }
    
    static var className: String {
        return String(describing: self)
    }
    
    static var reuseIdentifier: String {
        return className + ".identifier"
    }
}
