//
//  SearchResult.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/17/24.
//

import Foundation

struct SearchResult: Codable {
  let city: Location
  let weatherInfo: WeatherInfo

  enum CodingKeys: String, CodingKey {
    case city = "location"
    case weatherInfo = "current"
  }
}
