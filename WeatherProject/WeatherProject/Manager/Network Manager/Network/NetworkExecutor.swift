//
//  NetworkExecutor.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

class NetworkExecutor<ServiceRequest: RouteDefinition>: RequestExecutor {
    
    private var task: URLSessionDataTask?
    
    func excuteRequest(_ service: ServiceRequest, completion: @escaping RequestDataTaskCompletion) {
        let urlSession = URLSession.shared
        self.task = urlSession.dataTask(with: service.urlRequest, completionHandler: { (data, response, error) in
            completion(data, response, error)
        })
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
