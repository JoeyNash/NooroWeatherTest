//
//  SearchTextField.swift
//  NooroWeather
//
//  Created by Joseph Nash on 12/13/24.
//

import SwiftUI

class SearchTextFieldViewModel: ObservableObject {
  @Published var searchText: String = ""
}

struct SearchTextField: View {
  @ObservedObject var viewModel: SearchTextFieldViewModel
  var body: some View {
    HStack {
      TextField("Search Location", text: $viewModel.searchText)
        .padding()
      Image(systemName: "magnifyingglass")
        .renderingMode(.template)
        .foregroundColor(Color(red: 196/255, green: 196/255, blue: 196/255))
        .padding()
    }
    .background(Color(red: 242/255, green: 242/255, blue: 242/255))
    .cornerRadius(16)
  }
}

struct SearchTextField_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      SearchTextField(viewModel: SearchTextFieldViewModel())
      Spacer()
    }
  }
}
