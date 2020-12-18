//
//  Fileable.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

protocol Fileable {
    var name: String { get }
    var fileName: String { get }
    var data: Data { get }
    var mimeType: String { get }
}
