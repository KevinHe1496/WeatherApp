//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    @State var appState = AppState() // ViewModel Global
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
        }
    }
}

