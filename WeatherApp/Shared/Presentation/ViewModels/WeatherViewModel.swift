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
  
    var citySeached: String
    var cityName: String = ""
    var weather = [WeatherData]()
    var temperature: Double = 0.0
    var country: String = ""
    var icon: String = ""
    let conditionID = 0
    
    @ObservationIgnored
    private var useCase: WeatherUseCaseProtocol
    
    init(useCase: WeatherUseCaseProtocol = WeatherUseCase(), citySeached: String = "") {
        self.useCase = useCase
        self.citySeached = citySeached
        Task {
            await getWeather()
        }
    }
    
    
    @MainActor
    func getWeather() async {
        let data = await useCase.fetchWeatherCity(city: citySeached)
        cityName = data.name
        weather = data.weather
        temperature = data.main.temp
        country = data.sys.country
        
    }
    

    
}
