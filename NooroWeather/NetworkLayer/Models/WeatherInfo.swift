//
//  WeatherInfo.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/13/24.
//

import Foundation

struct WeatherInfo: Codable {
  let cloudCover: Int
  let conditionText: String
  let conditionIcon: String
  let conditionCode: Int
  let dewPointCelsius: Double
  let dewPointFarenheit: Double
  let feelsLikeCelsius: Double
  let feelsLikeFarenheit: Double
  let gustKPH: Double
  let gustMPH: Double
  let heatIndexCelsius: Double
  let heatIndexFarenheit: Double
  let humidity: Int
  private let isDay: Int
  let lastUpdated: String
  let lastUpdatedEpoch: Int
  let precipitationInches: Double
  let precipitationMillimeters: Double
  let pressureInches: Double
  let pressureMillibars: Double
  let tempCelsius: Double
  let tempFarenheit: Double
  let uvIndex: Double
  let windChillCelsius: Double
  let windChillFarenheit: Double
  let windDegree: Int
  let windDirection: String
  let windKPH: Double
  let windMPH: Double

  /// Calculated property for daytime.
  ///  - NOTE: API returns daytime as Int 0 or 1. This is a simple convenient conversion
  var isDayTime: Bool {
    isDay == 1
  }

  enum CodingKeys: String, CodingKey {
    case cloudCover = "cloud"
    case conditionText = "condition:text"
    case conditionIcon = "condition:icon"
    case conditionCode = "condition:code"
    case dewPointCelsius = "dewpoint_c"
    case dewPointFarenheit = "dewpoint_f"
    case feelsLikeCelsius = "feelslike_c"
    case feelsLikeFarenheit = "feelslike_f"
    case gustKPH = "gust_kph"
    case gustMPH = "gust_mph"
    case heatIndexCelsius = "heatindex_c"
    case heatIndexFarenheit = "heatindex_f"
    case humidity
    case isDay = "is_day"
    case lastUpdated = "last_updated"
    case lastUpdatedEpoch = "last_updated_epoch"
    case precipitationInches = "precip_in"
    case precipitationMillimeters = "precip_mm"
    case pressureInches = "pressure_in"
    case pressureMillibars = "pressure_mb"
    case tempCelsius = "temp_c"
    case tempFarenheit = "temp_f"
    case uvIndex = "uv"
    case windChillCelsius = "windchill_c"
    case windChillFarenheit = "windchill_f"
    case windDegree = "wind_degree"
    case windDirection = "wind_dir"
    case windKPH = "wind_kph"
    case windMPH = "wind_mph"
  }
}
