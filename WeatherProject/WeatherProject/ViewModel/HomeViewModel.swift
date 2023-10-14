//
//  HomeViewModel.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation
import CoreLocation

typealias WeatherCompletionHandler = (Result<WeatherModel, Error>) -> Void

/// This class acts as the view model for ViewController.
class HomeViewModel: NSObject {
    private var homeAPIService: HomeAPIService
    private var locationHandler: LocationHandler
    // MARK: - Initialisation
    
    init(homeApiService: HomeAPIService, locationHandler: LocationHandler) {
        self.homeAPIService = homeApiService
        self.locationHandler = locationHandler
        super.init()
    }
    
    
    // MARK: - Fetch Location
    
    /// This function is used to get a user's device's current location using location manager and then fetch weather at the obtained location if city is nil.
    /// - Parameters:
    ///   - cityName: cityName
    ///   - completion: completion handler to return data
    func fetchLocationWeather(cityName: String?, completion: @escaping WeatherCompletionHandler) {
        if cityName == nil || cityName?.isEmpty == true  {
            fetchCurrentWeather(completion: completion)
        }
        else {
            self.fetchCityWeather(cityName: cityName, completion: completion)
        }
    }
    
    // MARK: - Fetch Weather
    
    /// this function is used to get weather for a particular location entered by user
    /// - Parameters:
    ///   - cityName: a cityName
    ///   - completion: completion handler which returns the data
    private func fetchCityWeather(cityName: String?, completion: @escaping WeatherCompletionHandler) {
        var params : [String : Any] = [:]
        if let city = cityName {
            params = ["q": city]
        }
        params["days"] = 3
        
        callFetchWeatherService(params: params, completion: completion)
        
    }
    
    /// This function is used to fetch weather from given parameters via weather api
    /// - Parameters:
    ///   - params: weather params
    ///   - completion: completion block
    private func callFetchWeatherService(params: Parameters, completion: @escaping WeatherCompletionHandler) {
        homeAPIService.fetchWeather(params: params) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    completion(.success(weatherData))
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Fetch weather from user's current location
    /// - Parameter completion: completion block
    private func fetchCurrentWeather(completion: @escaping WeatherCompletionHandler) {
        locationHandler.getCurrentLocation {[weak self] (location, error) in
            guard let userLocation = location, let strongSelf = self else  { return }
            var params : [String : Any] = [:]
            params = ["q": "\(userLocation.coordinate.latitude)" + "," + "\(userLocation.coordinate.longitude)",
                      "days": 3
            ]
            strongSelf.callFetchWeatherService(params: params, completion: completion)
        }
    }
}
