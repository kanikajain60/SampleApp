//
//  RequestExecutor.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

typealias RequestDataTaskCompletion = (Data?, URLResponse?, Error?) -> Void

protocol RequestExecutor: AnyObject {
    associatedtype serviceRequest: RouteDefinition
    
    func excuteRequest(_ service: serviceRequest, completion: @escaping RequestDataTaskCompletion)
    func cancel()
}

