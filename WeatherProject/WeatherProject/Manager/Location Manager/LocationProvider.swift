//
//  LocationProvider.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation
import MapKit

enum LocationError: Error {
    case couldNotBeLocated
    case userNotAuthorized
}

typealias LocationCompletionHandler = (Location?, LocationError?) -> Void

protocol LocationProvider {
    func getCurrentLocation(completion: @escaping LocationCompletionHandler)
}




