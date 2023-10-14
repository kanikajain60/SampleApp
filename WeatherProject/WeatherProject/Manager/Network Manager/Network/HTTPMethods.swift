//
//  HTTPMethods.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    var methodName: String { return rawValue.uppercased() }
}
