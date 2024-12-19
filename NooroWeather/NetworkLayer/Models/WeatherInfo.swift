//
//  WeatherInfo.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/13/24.
//

import Foundation

struct WeatherInfo: Codable {

  struct Condition: Codable {
    let text: String
    let code: Int
    let icon: String
  }
  let condition: Condition
  let feelsLikeCelsius: Double
  let feelsLikeFarenheit: Double
  let humidity: Int
  let tempCelsius: Double
  let tempFarenheit: Double
  let uvIndex: Double

  enum CodingKeys: String, CodingKey {
    case condition
    case feelsLikeCelsius = "feelslike_c"
    case feelsLikeFarenheit = "feelslike_f"
    case humidity
    case tempCelsius = "temp_c"
    case tempFarenheit = "temp_f"
    case uvIndex = "uv"
  }
}
