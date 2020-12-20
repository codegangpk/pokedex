//
//  BaseViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation
import Combine

class BaseViewViewModel {
    @Published var isLoading: Bool = false
    
    var subscribers = Set<AnyCancellable>()
}
