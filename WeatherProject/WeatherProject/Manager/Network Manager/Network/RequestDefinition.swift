//
//  RequestDefination.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

typealias Parameters = [String : Any]
typealias HTTPHeaders = [String : String]

protocol RouteDefinition {
    var urlRequest: URLRequest { get }
    var httpMethod: HTTPMethod {get}
    var baseUrl: String {get}
    var path: String {get}
    var headers: HTTPHeaders? {get}
    var parameters: Parameters? {get}
    var paramEncoder: ParamEncodable { get }
}

extension RouteDefinition {
    var urlRequest: URLRequest {
        var url = try? baseUrl.asURL()
        url?.appendPathComponent(path)

        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        request.httpMethod = httpMethod.methodName
        request.allHTTPHeaderFields = headers
        do {
            try paramEncoder.encode(parameters, with: &request)
        } catch {
            debugPrint(error)
        }
        debugPrint(request)
        return request
    }
}

