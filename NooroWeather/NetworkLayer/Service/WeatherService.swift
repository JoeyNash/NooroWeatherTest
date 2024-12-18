//
//  WeatherService.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/18/24.
//

import Foundation
import Combine

protocol WeatherService {
  /// Searches for possible cities
  /// - Parameter searchString: Name, lat/lon, or postal/zipcode to search by
  func searchCity(_ searchString: String) -> AnyPublisher<[SearchResult], Error>
  /// Takes a latitude/longitude string to search weather by location
  /// - Parameter latLon: Location string. "lat,lon" format
  /// - Note: Using lat/lon to avoid conflict with cities using the same name (i.e Springfield)
  func searchWeather(_ latLon: String) -> AnyPublisher<SearchResult, Error>
}

class NooroWeatherService: WeatherService {
  private static var rootSearchURLString: String = {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String else {
      return ""
    }
    return "http://api.weatherapi.com/v1/search.json?key=\(apiKey)&q="
  }()

  private static var rootWeatherURLString: String = {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String else {
      return ""
    }
    return "http://api.weatherapi.com/v1/current.json?key=\(apiKey)&q="
  }()

  private static var decoder: JSONDecoder = {
    JSONDecoder()
  }()

  func searchCity(_ searchString: String) -> AnyPublisher<[SearchResult], Error> {
    guard let requestURL = URL(string: Self.rootSearchURLString+searchString) else {
      return Fail(error: NSError(domain: "Bad URL", code: -1))
        .eraseToAnyPublisher()
    }
    let request = URLRequest(url: requestURL)
    return URLSession.shared.dataTaskPublisher(for: request)
      .tryMap { result in
        guard(result.response as? HTTPURLResponse)?.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        return result.data
      }
      .decode(type: [Location].self, decoder: Self.decoder)
      .flatMap { $0.publisher }
      .flatMap { self.searchWeather("\($0.lat),\($0.lon)") }
      .collect()
      .eraseToAnyPublisher()
  }

  func searchWeather(_ latLon: String) -> AnyPublisher<SearchResult, Error> {
    guard let requestURL = URL(string: Self.rootWeatherURLString+latLon) else {
      return Fail(error: NSError(domain: "Bad URL", code: -1))
        .eraseToAnyPublisher()
    }
    let request = URLRequest(url: requestURL)
    return URLSession.shared.dataTaskPublisher(for: request)
      .tryMap { result in
        guard(result.response as? HTTPURLResponse)?.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        return result.data
      }
      .decode(type: SearchResult.self, decoder: Self.decoder)
      .eraseToAnyPublisher()
  }
}
