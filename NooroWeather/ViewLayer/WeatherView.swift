//
//  WeatherView.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/16/24.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
  @Published var name: String
  @Published var weather: WeatherInfo
  
  init(name: String, weather: WeatherInfo) {
    self.name = name
    self.weather = weather
  }
}

struct WeatherView: View {
  @ObservedObject var viewModel: WeatherViewModel
  var body: some View {
    VStack {
      // Condition image
      AsyncImage(url: URL(string: viewModel.weather.conditionIcon)) { phase in
        switch phase {
          case .success(let image):
            image
              .resizable()
              .scaledToFill()
          case .empty:
            ProgressView().progressViewStyle(.circular)
          case .failure:
            Image(systemName: "xmark.icloud")
          @unknown default:
            EmptyView()
        }
      }
      .frame(width: 123, height: 123)
      .padding()
      // Name/Temp
      VStack {
        Text(viewModel.name)
          .font(.system(size: 30))
        Text("\(Int(viewModel.weather.tempFarenheit))°")
          .font(.system(size: 70))
      }
      // Details
      WeatherDetailView(
        viewModel: WeatherDetailViewModel(
          humidity: viewModel.weather.humidity,
          uvIndex: Int(viewModel.weather.uvIndex),
          feelsLike: Int(viewModel.weather.feelsLikeFarenheit)
        )
      )
    }
  }
}

struct WeatherView_Previews: PreviewProvider {
  static let mockWeatherViewModel = WeatherViewModel(
    name: "Norfolk",
    weather: WeatherInfo(
      conditionText: "Mist",
      conditionIcon: "",
      conditionCode: 1030,
      feelsLikeCelsius: 11.3,
      feelsLikeFarenheit: 52.4,
      humidity: 89,
      tempCelsius: 11.1,
      tempFarenheit: 52.0,
      uvIndex: 0.5
    )
  )
  static var previews: some View {
    VStack {
      Spacer()
      WeatherView(viewModel: mockWeatherViewModel)
      Spacer()
    }
  }
}
