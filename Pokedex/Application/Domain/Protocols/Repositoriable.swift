//
//  File.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/24.
//

import Foundation

protocol Repositoriable {
    var session: API { get }
    var baseURL: URL { get }
}
