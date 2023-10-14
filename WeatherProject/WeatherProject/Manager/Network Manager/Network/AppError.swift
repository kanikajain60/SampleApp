//
//  AppError.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

enum AppError: Error {
    
    enum RequestError: Error {
        case invalidURL(message: String)
    }
    
    enum APIError: Error {
        case noInternet(message: String)
    }
}
