//
//  NetworkService.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import Alamofire
import RxSwift

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
    func call<Model: Codable>(_ endPoint: EndPointable, for model: Model.Type) -> Observable<Model?> {
        return Single.create { single in
            let request = session
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
                .responseData(queue: .global(qos: .userInitiated)) { (response) in
                    let result: SingleEvent<Model?>
                    defer {
                        DispatchQueue.main.async {
                            single(result)
                            NetworkLogger.log(.inComing(response.data, response.response, response.error))
                        }
                    }
                    
                    if let error = response.error {
                        let networkError = NetworkError(responseCode: error.responseCode)
                        result = .error(networkError)
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
                        result = .error(NetworkError.modelParsingFailed)
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
        .asObservable()
    }
}
