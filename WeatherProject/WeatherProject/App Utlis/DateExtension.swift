//
//  DateExtension.swift
//  WeatherProject
//
//  Created by Kanika Jain on 13/10/23.
//

import Foundation

class DateExtension {
  
  /// Function to convert api date string to dd-MMM format
  /// - Parameter stringDate: api returned date string
  /// - Returns: view model date string
   static func getStringDate(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: stringDate)
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: date ?? Date())
        return dateString
    }
}
