//
//  BaseViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation
import RxSwift

class BaseViewViewModel {
    let isLoading: BehaviorSubject<Bool> = .init(value: false)
    let networkError: BehaviorSubject<NetworkError?> = .init(value: nil)
    
    let disposeBag = DisposeBag()
}

extension BaseViewViewModel {
    func beginNetworkRequest() {
        isLoading.onNext(true)
    }
    
    func completeNetworkRequest<T>(completion: Event<T>) {
        if case .error(let error) = completion {
            guard let networkError = error as? NetworkError else { return }
            
            self.networkError.onNext(networkError)
        }
        isLoading.onNext(false)
    }
}
