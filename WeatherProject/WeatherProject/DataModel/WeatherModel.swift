//
//  WeatherModel.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation


// MARK: - API Data Models
struct WeatherModel: Codable {
    let location: LocationData?
    let current: CurrentData?
    let forecast: ForecastData?
}

struct LocationData: Codable {
    let name: String?
    let region: String?
    let country: String?
}

struct CurrentData: Codable {
    let wind_kph: Double?
    let temp_c: Double?
    let condition: ConditionData?
}

struct ConditionData: Codable {
    let text: String?
    let code: Int?
}

struct ForecastData: Codable {
    let forecastday: [ForecastDay]?
}

struct ForecastDay: Codable {
    let date: String?
    let day: Day?
}

struct Day: Codable {
    let maxtemp_c: Double?
    let mintemp_c: Double?
    let avghumidity: Double?
    let condition: ConditionData?
}
