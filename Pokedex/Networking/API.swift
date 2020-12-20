//
//  API.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import Alamofire
import Combine

struct API {
    let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 10.0
        return Session(configuration: configuration)
    }()
    
    let encoding = URLEncoding(boolEncoding: .literal)
}

extension API {
    @discardableResult
    func call<Model: Codable>(_ endPoint: EndPointable, for model: Model.Type) -> AnyPublisher<Model, NetworkError> {
        Future { promise in
            session
                .request(
                    endPoint.url,
                    method: endPoint.afHttpMethod,
                    parameters: endPoint.parameters,
                    encoding: URLEncoding(boolEncoding: .literal),
                    headers: endPoint.afHttpHeaders
                )
                .validate()
                .onURLRequestCreation(perform: {
                    NetworkLogger.log(.outGoing($0))
                })
                .responseData { (response) in
                    NetworkLogger.log(.inComing(response.data, response.response, response.error))
                    if let error = response.error {
                        let networkError = NetworkError(responseCode: error.responseCode)
                        promise(.failure(networkError))
                    }
                    
                    guard let data = response.data else { return }
                    
                    do {
                        let responseObject = try JSONDecoder().decode(model, from: data)
                        promise(.success(responseObject))
                    } catch {
                        promise(.failure(NetworkError.modelParsingFailed))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
