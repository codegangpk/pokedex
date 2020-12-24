//
//  Bindable.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

protocol Bindable {
    associatedtype ViewModelable
    func bind(_ viewModel: ViewModelable)
}
