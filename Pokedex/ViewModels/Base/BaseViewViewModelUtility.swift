//
//  BaseViewViewModelUtility.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation
import Combine

class BaseViewViewModelUtility: ObservableObject {
    @Published var isLoading: Bool = false
    
    var subscribers = Set<AnyCancellable>()
}

extension BaseViewViewModelUtility {
    func call<T>(
        _ request: AnyPublisher<T, Error>,
        showLoader: Bool = true,
        completion: @escaping (Result<T, Error>) -> Void
    )
    {
        if showLoader {
            isLoading = true
        }
        
        request.sink { [weak self] error in
            guard let self = self else { return }
            
            self.isLoading = false
            switch error {
            case .finished:
                break
            case .failure(let error):
                completion(.failure(error))
            }
        } receiveValue: { value in
            completion(.success(value))
        }
        .store(in: &subscribers)
    }
}
