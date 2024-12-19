//
//  NooroWeatherApp.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/13/24.
//

import SwiftUI

@main
struct NooroWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            HomePageView(
              viewModel: HomePageViewModel(withCity: UserDefaultsService.getSelectedLocation()),
              weatherService: NooroWeatherService()
            )
        }
    }
}
