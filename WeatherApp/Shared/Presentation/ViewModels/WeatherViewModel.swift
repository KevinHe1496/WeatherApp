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
    var max_temperature: Double = 0.0
    var min_Temperature: Double = 0.0
    var humidity: Int = 0
    var id: Int = 0
    
    @ObservationIgnored
    private var useCase: WeatherUseCaseProtocol
    
    init(useCase: WeatherUseCaseProtocol = WeatherUseCase(), citySeached: String = "") {
        self.useCase = useCase
        self.citySeached = citySeached
        Task {
            await getWeather()
        }
        
    }
    
    var getIcon: String {
        switch id {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog"
        case 801...804:
            return "cloud.fill"
        default:
            return "sun.max.fill"
        }
    }
    
    
    
    @MainActor
    func getWeather() async {
        let data = await useCase.fetchWeatherCity(city: citySeached)
        cityName = data.name
        weather = data.weather
        temperature = data.main.temp
        country = data.sys.country
        max_temperature = data.main.temp_max
        min_Temperature = data.main.temp_min
        humidity = data.main.humidity
        id = weather[0].id
        
        
    }
}
