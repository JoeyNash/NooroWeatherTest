//
//  ContentView.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/13/24.
//

import SwiftUI
import Combine

class HomePageViewModel: ObservableObject {
  @Published var selectedCity: String?
  @Published var selectedWeather: SearchResult?
  @Published var searchResults: [SearchResult] = []

  init(withCity selectedCity: String? = nil) {
    self.selectedCity = selectedCity
  }

  var subscriptions = Set<AnyCancellable>()

  func searchWeather(using service: WeatherService) {
    if let selectedLocation = selectedCity {
      service.searchWeather(selectedLocation)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { result in
          switch result {
            case .failure(let error):
              print(error)
            default:
              break
          }
        }, receiveValue: { [weak self] result in
          guard let self = self else { return }
          self.selectedWeather = result
        })
        .store(in: &subscriptions)
    }
  }

  func searchCities(service: WeatherService, searchString: String) {
    service.searchCity(searchString)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { result in
        switch result {
          case .failure(let error):
            print(error)
          default:
            break
        }
      }, receiveValue: { [weak self] results in
        guard let self = self else { return }
        self.searchResults = results
      })
      .store(in: &subscriptions)
  }
}

struct HomePageView: View {

  func setSelectedLocation(_ result: SearchResult) {
    viewModel.selectedCity = result.city.name
    viewModel.selectedWeather = result
    UserDefaultsService.setSelectedLocation("\(result.city.lat),\(result.city.lon)")
  }

  func resetSearch() {
    searchModel.searchText = ""
    viewModel.searchResults = []
  }

  @ObservedObject var searchModel = SearchTextFieldViewModel()
  @ObservedObject var viewModel: HomePageViewModel
  var weatherService: WeatherService

  var body: some View {
    VStack {
      SearchTextField(viewModel: searchModel)
        .onChange(of: searchModel.searchText, perform: { _ in
          viewModel.searchCities(service: self.weatherService, searchString: searchModel.searchText)
        })
        .padding()
      if !viewModel.searchResults.isEmpty {
        // Prioritize showing search results
        ScrollView {
          ForEach(viewModel.searchResults, id: \.city.id) { result in
            Button(action: { setSelectedLocation(result)
              resetSearch()
            }) {
              SearchResultView(
                viewModel: SearchResultViewModel(
                  name: result.city.name,
                  temperatureString: "\(Int(result.weatherInfo.tempFarenheit))",
                  iconURL: result.weatherInfo.condition.icon
                )
              )
            }
            .padding()
          }
        }
      } else if !searchModel.searchText.isEmpty {
        // Search with no results. Force update to empty screen
        Spacer()
      } else if let selectedSearch = viewModel.selectedWeather {
        // Show current selected city's weather
        Spacer()
        WeatherView(
          viewModel: WeatherViewModel(
            name: selectedSearch.city.name,
            weather: selectedSearch.weatherInfo
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
    .task({
      viewModel.searchWeather(using: weatherService)
    })
  }
}

struct HomePageView_Previews: PreviewProvider {
  class MockWeatherService: WeatherService {
    func searchCity(_ searchString: String) -> AnyPublisher<[SearchResult], Error> {
      return Just([SearchResult]())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    
    func searchWeather(_ latLon: String) -> AnyPublisher<SearchResult, Error> {
      return Just(
        SearchResult(
          city: Location(lat: 0, lon: 0, name: "", region: ""),
          weatherInfo: WeatherInfo(
            condition: .init(
              text: "",
              code: 0,
              icon: ""
              ),
            feelsLikeCelsius: 0,
            feelsLikeFarenheit: 0,
            humidity: 0,
            tempCelsius: 0,
            tempFarenheit: 0,
            uvIndex: 0
          )
        )
      )
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
    }
    
    
  }
  static var previews: some View {
    HomePageView(
      viewModel: HomePageViewModel(),
      weatherService: MockWeatherService()
    )
  }
}
