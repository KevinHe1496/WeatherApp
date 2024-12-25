//
//  AppState.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation
import Combine

@Observable
final class AppState{
    
    var status = Status.none
    
    @ObservationIgnored
    private var weatherUseCase: WeatherUseCaseProtocol
    
    init(weatherUseCase: WeatherUseCaseProtocol = WeatherUseCase()) {
        self.weatherUseCase = weatherUseCase
    }
    
    @MainActor
    func getWeather(citySearched: String) {
        self.status = .loading
        
        Task {
            await weatherUseCase.fetchWeatherCity(city: citySearched)
            self.status = .loaded
            
        }
    }
}
