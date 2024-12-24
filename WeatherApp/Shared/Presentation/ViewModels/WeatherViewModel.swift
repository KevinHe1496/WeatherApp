//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation
import Combine

@Observable
final class WeatherViewModel {
    
    var weatherData = [WeatherData]()
    private var cityName: String
    
    @ObservationIgnored
    private var useCase: WeatherUseCaseProtocol
    
    init(useCase: WeatherUseCaseProtocol = WeatherUseCase(), cityName: String) {
        self.useCase = useCase
        self.cityName = cityName
        Task {
            await getWeather()
        }
    }
    
    @MainActor
    func getWeather() async {
        let data = await useCase.fetchWeatherCity(city: cityName)
    }
}
