//
//  NetworkService.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import Alamofire
import Combine

struct NetworkService {
    static let shared: NetworkService = NetworkService()
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 10.0
        return Session(configuration: configuration)
    }()
    
    private init() {}
}

extension NetworkService {
    @discardableResult
    func call<Model: Codable>(_ endPoint: EndPointable, for model: Model.Type) -> AnyPublisher<Model?, NetworkError> {
        Future { promise in
            session
                .request(
                    endPoint.url,
                    method: endPoint.afHttpMethod,
                    parameters: endPoint.parameters,
                    encoding: URLEncoding(boolEncoding: .literal),
                    headers: endPoint.afHttpHeaders
                )
                .onURLRequestCreation(perform: {
                    NetworkLogger.log(.outGoing($0))
                })
                .validate()
                .responseData(queue: .global(qos: .utility)) { (response) in
                    NetworkLogger.log(.inComing(response.data, response.response, response.error))
                    
                    let result: Result<Model?, NetworkError>
                    defer {
                        DispatchQueue.main.async {
                            promise(result)
                        }
                    }
                    
                    if let error = response.error {
                        let networkError = NetworkError(responseCode: error.responseCode)
                        result = .failure(networkError)
                        return
                    }
                    
                    guard let data = response.data else {
                        result = .success(nil)
                        return
                    }
                    
                    do {
                        let responseObject = try JSONDecoder().decode(model, from: data)
                        result = .success(responseObject)
                    } catch {
                        result = .failure(NetworkError.modelParsingFailed)
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
