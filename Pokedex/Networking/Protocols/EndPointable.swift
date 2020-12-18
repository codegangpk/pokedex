//
//  EndPointable.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import Alamofire

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]
typealias Files = [Fileable]

protocol EndPointable {
    var baseURL: URL { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var arrayOfParameters: [Parameters]? { get }
    var headers: HTTPHeaders? { get }
    var files: Files? { get }
}

extension EndPointable {
    var url: URL {
        return baseURL.appendingPathComponent(path)
    }
}

extension EndPointable {
    var afHttpHeaders: Alamofire.HTTPHeaders? {
        guard let headers = headers else { return nil }
        
        return Alamofire.HTTPHeaders(headers)
    }
    
    var afHttpMethod: Alamofire.HTTPMethod {
        switch httpMethod {
        case .options: return .options
        case .get: return .get
        case .head: return .head
        case .post: return .post
        case .put: return .put
        case .patch: return .patch
        case .delete: return .delete
        case .trace: return .trace
        case .connect: return .connect
        }
    }
}

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
    
    var value: String {
        return self.rawValue
    }
}
