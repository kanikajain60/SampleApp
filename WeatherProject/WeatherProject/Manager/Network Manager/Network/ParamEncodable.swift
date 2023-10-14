//
//  ParamEncodable.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

protocol ParamEncodable {
    func encode(_ params: Parameters?, with request: inout URLRequest) throws
}

struct URLEncode: ParamEncodable {
    func encode(_ params: Parameters?, with request: inout URLRequest) throws {
        guard var parameters = params else { return }
        parameters["key"] = "e1d1ac4497ed44059fd61325231110"
        guard let url = request.url else { throw AppError.RequestError.invalidURL(message: "No URL found") }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = parameters.map({ (key, value) -> URLQueryItem in
                return URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            })
            request.url = urlComponents.url
        }
    }
        
    
}
