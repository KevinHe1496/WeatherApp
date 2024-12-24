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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear{
            Task {
                await network.fetchWeatherCity(city: "quito")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
