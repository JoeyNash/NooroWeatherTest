//
//  UserDefaultsService.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/17/24.
//

import Foundation

class UserDefaultsService {
  static let selectedCityKey = "selected_city"

  static func setSelectedCity(_ city: String) {
    UserDefaults.standard.set(city, forKey: selectedCityKey)
  }

  static func getSelectedCity() -> String? {
    UserDefaults.standard.string(forKey: selectedCityKey)
  }
}
