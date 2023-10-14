//
//  HomeAPIService.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

typealias WeatherCompletionBlock = (Result<WeatherModel, Error>)  -> Void

/// This class is used to make network request for Home View Controller
class HomeAPIService: NetworkExecutor<HomeRepository>, ResponseRepresentable {
    
    /// This method is fetching the weather for given parameters
    /// - Parameters:
    ///   - params: param
    ///   - completion: completion
    func fetchWeather(params: Parameters, completion: @escaping WeatherCompletionBlock) {
        excuteRequest(HomeRepository.fetchWeather(params)) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else if let response = response as? HTTPURLResponse {
                let apiResult = self.handleNetworkResponse(response)
                switch apiResult {
                case .success:
                    if let data = data {
                        do {
                            let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                            completion(.success(weatherModel))
                            return
                        } catch {
                            completion(.failure(APIResponseError.failed))
                        }
                    } else {
                        completion(.failure(APIResponseError.noData))
                    }
                case .failure:
                    completion(.failure(APIResponseError.failed))
                }
            } else {
                completion(.failure(APIResponseError.nilResponse))
            }
        }
    }
}
