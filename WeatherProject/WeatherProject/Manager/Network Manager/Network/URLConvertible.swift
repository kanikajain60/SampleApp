//
//  URLConvertible.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

protocol URLConvertible {
    func asURL() throws -> URL
}

extension String: URLConvertible {
    func asURL() throws -> URL {
        guard let url = URL(string: self)
            else { throw AppError.RequestError.invalidURL(message: "Invalid URL string") }
        return url
    }
    
}

