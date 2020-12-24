//
//  Endpoint.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

struct EndPoint: EndPointable {
    let baseURL: URL
    var httpMethod: HTTPMethod
    let path: String
    let parameters: Parameters?
    let arrayOfParameters: [Parameters]?
    let headers: HTTPHeaders?
    let files: Files?
    
    init(
        baseURL: URL,
        httpMethod: HTTPMethod,
        path: String,
        headers: HTTPHeaders? = nil,
        parameters: Parameters? = nil,
        arrayOfParameters: [Parameters]? = nil,
        files: Files? = nil
    ) {
        self.baseURL = baseURL
        self.httpMethod = httpMethod
        self.path = path
        self.parameters = parameters
        self.arrayOfParameters = arrayOfParameters
        self.headers = headers
        self.files = files
    }
}
