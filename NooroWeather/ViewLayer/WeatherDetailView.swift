//
//  WeatherDetailView.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/16/24.
//

import SwiftUI

class WeatherDetailViewModel: ObservableObject {
  @Published var humidity: Int
  @Published var uvIndex: Int
  @Published var feelsLike: Int
  
  init(humidity: Int, uvIndex: Int, feelsLike: Int) {
    self.humidity = humidity
    self.uvIndex = uvIndex
    self.feelsLike = feelsLike
  }
}

struct WeatherDetailView: View {
  @ObservedObject var viewModel: WeatherDetailViewModel
  var body: some View {
    HStack {
      VStack {
        Text("Humidity")
          .foregroundColor(Color(red: 196/255, green: 196/255, blue: 196/255))
          .font(.system(size: 12))
        Text("\(viewModel.humidity)%")
          .foregroundColor(Color(red: 154/255, green: 154/255, blue: 154/255))
          .font(.system(size: 15))
      }
      .padding()
      VStack {
        Text("UV")
          .foregroundColor(Color(red: 196/255, green: 196/255, blue: 196/255))
          .font(.system(size: 12))
        Text("\(viewModel.uvIndex)")
          .foregroundColor(Color(red: 154/255, green: 154/255, blue: 154/255))
          .font(.system(size: 15))
      }
      .padding()
      VStack {
        Text("Feels like")
          .foregroundColor(Color(red: 196/255, green: 196/255, blue: 196/255))
          .font(.system(size: 8))
        Text("\(viewModel.feelsLike)°")
          .foregroundColor(Color(red: 154/255, green: 154/255, blue: 154/255))
          .font(.system(size: 15))
      }
      .padding()
    }
    .background(Color(red: 242/255, green: 242/255, blue: 242/255))
    .cornerRadius(16)
  }
}

struct WeatherDetailView_Previews: PreviewProvider {
  static let mockViewModel = WeatherDetailViewModel(
    humidity: 89,
    uvIndex: 0,
    feelsLike: 52
  )
  static var previews: some View {
    VStack {
      Spacer()
      WeatherDetailView(viewModel: mockViewModel)
      Spacer()
    }
    }
}
