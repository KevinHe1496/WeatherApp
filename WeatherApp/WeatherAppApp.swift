//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: WeatherViewModel(), weather7DaysViewModel: Weather7DaysViewModel())
        }
    }
}

