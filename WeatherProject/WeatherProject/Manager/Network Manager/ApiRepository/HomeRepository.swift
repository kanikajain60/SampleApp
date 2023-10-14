//
//  HomeRepository.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

enum HomeRepository {
    case fetchWeather(_ param: Parameters?)
}

extension HomeRepository: RouteDefinition {
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchWeather:
            return .GET
        }
    }
        
    var baseUrl: String {
        switch self {
        case .fetchWeather:
            return kAppBaseUrl
        }
    }
    
    var path: String {
        switch self {
        case .fetchWeather:
            return "forecast.json"
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchWeather(let param):
            return param
        }
    }
    
    var paramEncoder: ParamEncodable {
        switch self {
        case .fetchWeather:
            return URLEncode()
        }
    }
    
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
