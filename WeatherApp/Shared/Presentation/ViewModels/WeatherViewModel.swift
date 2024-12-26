//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation
import Combine
import CoreLocation

@Observable
final class WeatherViewModel {
    
    var weathercityModel = WeatherCityModel.init(weather: [], dt: 0, name: "", main: MainData(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, humidity: 0), sys: Sys(country: ""))
    
    var citySeached: String
    var cityName: String = ""
    
    @ObservationIgnored
    private var useCase: WeatherUseCaseProtocol
    
    
    init(useCase: WeatherUseCaseProtocol = WeatherUseCase(), citySeached: String = ""){
        self.useCase = useCase
        self.citySeached = citySeached
        Task {
            await getWeather()
        }
    }
    
    @MainActor
    func getWeather() async  {
        do {
            let data = try await useCase.fetchWeatherCity(city: citySeached)
            weathercityModel = data
        } catch {
            print("Error en obtener la data")
        }
        
    }
    
    //MARK: - Weather API
    
    ///Get city name
    var city_name: String {
        cityName = weathercityModel.name
        return cityName
    }
    
    /// Get min temperature
    var min_Temperature: String {
        let min_Temperature = weathercityModel.main.temp_min
        return String(format: "%.1f °", min_Temperature)
    }
    
    /// Get max temperature
    var max_Temperature: String {
        let max_Temperature = weathercityModel.main.temp_max
        return String(format: "%.1f °", max_Temperature)
    }
    
    /// Get himidity
    var humidityWeather: String {
        let humidity = weathercityModel.main.humidity
        return String("\(humidity) %")
    }
    
    /// Get Icon
    var getIcon: String {
        if weathercityModel.weather.count != 0 {
           let id = weathercityModel.weather[0].id
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
        return ""
    }
    
    ///Get the temperature
    var temperature: String {
        let temp = weathercityModel.main.temp
            return String(format: "%.0f °", temp)
    }
    
//    Get the country
    var countryName: String {
        let ct = weathercityModel.sys.country
            return ct
    }
    
    ///Get Description
    var weatherDescription: String {
        if weathercityModel.weather.count != 0 {
            let description = weathercityModel.weather[0].description
                return description
        }
        return ""
    }
    
    //MARK: - Current date
    private func dateFormatter(timeStamp: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
    
    var date: String {
        return dateFormatter(timeStamp: weathercityModel.dt)
    }
}
