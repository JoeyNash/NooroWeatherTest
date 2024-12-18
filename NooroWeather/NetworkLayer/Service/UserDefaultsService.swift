//
//  UserDefaultsService.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/17/24.
//

import Foundation

class UserDefaultsService {
  static let selectedLocationKey = "selected_location"

  static func setSelectedLocation(_ location: String) {
    UserDefaults.standard.set(location, forKey: selectedLocationKey)
  }

  static func getSelectedLocation() -> String? {
    UserDefaults.standard.string(forKey: selectedLocationKey)
  }
}
