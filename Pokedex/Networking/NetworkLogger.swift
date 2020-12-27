//
//  NetworkLogger.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

struct NetworkLogger {
    enum Mode {
        case outGoing(URLRequest), inComing(Data?, URLResponse?, Error?)
    }
    
    static func log(_ mode: Mode, id: String? = nil) {
        #if DEBUG
        switch mode {
        case .outGoing(let request):
            let urlString = request.url?.absoluteString ?? ""
            let components = URLComponents(string: urlString)
            
            let method = request.httpMethod ?? ""
            let path = components?.path
            let query = components?.query
            let host = components?.host ?? ""
            
            var requestLog = "\n---------- OUT ---------->\n\n"
            if let id = id {
                requestLog += "UUID: \(id)\n"
            }
            requestLog += "\(urlString)\n\n"
            
            let fullPath = [path, query].compactMap { $0 }.joined(separator: "?")
            requestLog += "\(method) \(fullPath)\n"
            requestLog += "Host: \(host)\n\n"
            
            requestLog += "<Headers>\n"
            request.allHTTPHeaderFields?.forEach {
                requestLog += "\($0.key): \($0.value)\n"
            }
            
            requestLog += "\n<Body>\n"
            if let httpBody = request.httpBody {
                let body = String(data: httpBody, encoding: .utf8) ?? "Can't render body; not utf8 encoded"
                requestLog += "\(body)\n"
            }
            
            requestLog += "\n------------------------->\n"
            print(requestLog)
        case .inComing(let data, let response, let error):
            let urlString = response?.url?.absoluteString
            let components = URLComponents(string: urlString ?? "")
            
            let path = components?.path
            let query = components?.query
            
            var responseLog = "\n<---------- IN ----------\n"
            if let id = id {
                responseLog += "UUID: \(id)\n"
            }
            if let urlString = urlString {
                responseLog += "\n\(urlString)\n\n"
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                let fullPath = [path, query].compactMap { $0 }.joined(separator: "?")
                responseLog += "HTTP \(statusCode) \(fullPath)\n"
            }
            if let host = components?.host {
                responseLog += "Host: \(host)\n\n"
            }
            
            responseLog += "<Headers>\n"
            (response as? HTTPURLResponse)?.allHeaderFields.forEach {
                responseLog += "\($0.key): \($0.value)\n"
            }
            
            if let bodyData = data {
                responseLog += "\n<Body>\n"
                let body = bodyData.prettyPrintedJSON ?? "Can't render body; not utf8 encoded"
                responseLog += "\(body)\n"
            }
            if let error  = error {
                responseLog += "\nError: \(error.localizedDescription)\n"
            }
            responseLog += "\n<-------------------------\n"
            print(responseLog)
        }
        #endif
    }
}
