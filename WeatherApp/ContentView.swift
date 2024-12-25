//
//  ContentView.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import SwiftUI

struct ContentView: View {
    
    var network = NetworkWeatherCity()
    
    init() {
    }
    
    var body: some View {
        VStack {
            Button {
                WeatherView(viewModel: WeatherViewModel())
            } label: {
                Text("Go to Weather Forecaste")
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
