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
  let region: String
}

extension Location: Identifiable {
  var id: String {
    name + ", " + region
  }
  
  
}
