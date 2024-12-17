//
//  ContentView.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/13/24.
//

import SwiftUI

class HomePageViewModel: ObservableObject {
  @Published var selectedCity: String?
  @Published var selectedWeather: WeatherInfo?
  @Published var searchResults: [SearchResult] = []

  init(withCity selectedCity: String? = nil) {
    self.selectedCity = selectedCity
  }
}

struct HomePageView: View {

  func setSelectedCity(_ city: SearchResult) {
    viewModel.selectedCity = city.name
    viewModel.selectedWeather = city.weatherInfo
    UserDefaultsService.setSelectedCity(city.name)
  }

  @ObservedObject var searchModel = SearchTextFieldViewModel()
  @ObservedObject var viewModel: HomePageViewModel
  
  var body: some View {
    VStack {
      SearchTextField(viewModel: searchModel)
        .padding()
      if !viewModel.searchResults.isEmpty {
        // Prioritize showing search results
        ScrollView {
          ForEach(viewModel.searchResults, id: \.name) { city in
            Button(action: { setSelectedCity(city)}) {
              SearchResultView(
                viewModel: SearchResultViewModel(
                  name: city.name,
                  temperatureString: "\(Int(city.weatherInfo.tempFarenheit))",
                  iconURL: city.weatherInfo.conditionIcon
                )
              )
            }
          }
        }
      } else if !searchModel.searchText.isEmpty {
        // Search with no results. Force update to empty screen
        Spacer()
        EmptyView()
      } else if let selectedCity = viewModel.selectedCity,
                let weatherInfo = viewModel.selectedWeather {
        // Show current selected city's weather
        Spacer()
        WeatherView(
          viewModel: WeatherViewModel(
            name: selectedCity,
            weather: weatherInfo
          )
        )
        Spacer()
      } else {
        // Nothing to show yet
        Spacer()
        Text("No City Selected")
          .font(.system(size: 30))
        Text("Please Search For A City")
          .font(.system(size: 15))
        Spacer()
      }
    }
  }
}

struct HomePageView_Previews: PreviewProvider {
  static var previews: some View {
    HomePageView(
      viewModel: HomePageViewModel()
    )
  }
}
