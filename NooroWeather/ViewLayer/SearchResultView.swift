//
//  SearchResultView.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/16/24.
//

import SwiftUI

class SearchResultViewModel: ObservableObject {
  @Published var name = ""
  @Published var temperatureString = ""
  @Published var iconURL = ""

  init(name: String,
       temperatureString: String,
       iconURL: String) {
    self.name = name
    self.temperatureString = temperatureString
    self.iconURL = iconURL
  }
}

struct SearchResultView: View {
  @ObservedObject var viewModel: SearchResultViewModel
  var body: some View {
    HStack {
      VStack {
        Text(viewModel.name)
          .font(.system(size: 20))
          .foregroundColor(.init(red: 44/255, green: 44/255, blue: 44/255))
        Text(viewModel.temperatureString)
          .font(.system(size: 60))
          .foregroundColor(.init(red: 44/255, green: 44/255, blue: 44/255))
      }
      .padding()
      Spacer()
      AsyncImage(url: URL(string: viewModel.iconURL.replacingOccurrences(of: "//", with: "https://"))) { phase in
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
      .frame(width: 83, height: 67)
      .padding()
    }
    .background(Color(red: 242/255, green: 242/255, blue: 242/255))
    .cornerRadius(16)
  }
}

struct SearchResultView_Previews: PreviewProvider {
  static let mockViewModel = SearchResultViewModel(
    name: "Mumbai",
    temperatureString: "20",
    iconURL: "")
  static var previews: some View {
    VStack {
      Spacer()
      SearchResultView(viewModel: mockViewModel)
      Spacer()
    }
  }
}
