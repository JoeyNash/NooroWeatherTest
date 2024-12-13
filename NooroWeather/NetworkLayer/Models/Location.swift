//
//  Location.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/13/24.
//

import Foundation

struct Location: Codable {
  let lat: Double
  let lon: Double
  let name: String
  let region:  String
  let country:  String
  let timeZoneId:  String
  let localEpochTime: Int
  let localTime:  String

  enum CodingKeys: String, CodingKey {
    case country, lat, lon, name, region
    case localEpochTime = "localtime_epoch"
    case localTime = "localTime"
    case timeZoneId = "tz_id"
  }
}
