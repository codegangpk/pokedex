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
    @Published var networkError: NetworkError?
    
    var subscribers = Set<AnyCancellable>()
}

extension BaseViewViewModel {
    func beginNetworkRequest() {
        self.isLoading = true
    }
    
    func completeNetworkRequest(completion: Subscribers.Completion<NetworkError>) {
        if case .failure(let networkError) = completion {
            self.networkError = networkError
        }
        self.isLoading = false
    }
}
