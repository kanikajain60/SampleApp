//
//  Environment.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

enum Environment {
    case dev
    case preprod
    case prod
    
    var urlProtocol: String {
        switch self {
        case .dev, .preprod, .prod:
            return "https"
        }
    }
    
    var appDomain: String {
        switch self {
        case .dev, .preprod, .prod:
            return "api.weatherapi.com"
        }
    }

    var router: String {
        switch self {
        case .dev, .preprod, .prod:
            return "v1"
        }
    }
    
    var baseUrl: String {
        return urlProtocol+"://"+appDomain+"/"+router+"/"
    }
}
