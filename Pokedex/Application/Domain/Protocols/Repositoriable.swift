//
//  File.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/24.
//

import Foundation

protocol Repositoriable {
    var networkService: NetworkService { get }
    var baseURL: URL { get }
}
