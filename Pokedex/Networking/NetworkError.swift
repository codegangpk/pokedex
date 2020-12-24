//
//  NetworkError.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

struct NetworkError: Error {
    let responseCode: Int?
    let errorMessage: String?
    
    init(responseCode: Int? = nil, errorMessage: String? = nil) {
        self.responseCode = responseCode
        self.errorMessage = errorMessage
    }
}

extension NetworkError {
    static var modelParsingFailed: NetworkError {
        NetworkError(errorMessage: "Model Parsing Failed")
    }
}
