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
    @Published var completion: Subscribers.Completion<NetworkError>?
    
    var subscribers = Set<AnyCancellable>()
}

extension BaseViewViewModel {
    func handleNetworkBegin() {
        self.isLoading = true
    }
    
    func handleNetworkCompletion(completion: Subscribers.Completion<NetworkError>) {
        self.completion = completion
        self.isLoading = false
    }
}
