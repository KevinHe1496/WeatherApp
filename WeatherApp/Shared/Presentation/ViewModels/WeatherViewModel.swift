//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation
import Combine
import CoreLocation


final class WeatherViewModel: ObservableObject {
    
    @Published var weathercityModel = WeatherCityModel(coord: Coord(lon: 0.0, lat: 0.0), weather: [WeatherData(id: 0, main: "", description: "", icon: "")], dt: 0, name: "", main: MainData(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, humidity: 0), sys: Sys(country: ""))
    
    @Published var citySeached: String
    @Published var cityName: String = ""
    @Published var status = Status.none
    @Published var longitude: Double = 0.0
    @Published var latitude: Double = 0.0
    
    
    private var useCase: WeatherUseCaseProtocol
    private var locationManager = LocationManager()
    
    init(useCase: WeatherUseCaseProtocol = WeatherUseCase(), citySeached: String = ""){
        self.useCase = useCase
        self.citySeached = citySeached
    }
    
    //MARK: - Get Weather
    @MainActor
    func getWeather() async {
        self.status = .loading
        do {
            let data = try await useCase.fetchWeatherCity(city: citySeached)
            self.weathercityModel = data
            self.latitude = data.coord.lat
            self.longitude = data.coord.lon
            
            self.status = .loaded
        } catch {
            self.status = .error(error: "Error en obtener data weather \(error.localizedDescription)")
        }
    }
    
    
    //MARK: - Get Location
    @MainActor
    func getLocation() async {
        self.status = .loading
        do {
            let data = try await useCase.fetchWeather(lat: locationManager.userLatitude, lon: locationManager.userLongitude)
            self.weathercityModel = data
            self.status = .loaded
        } catch {
            self.status = .error(error: "Error en obtener la locacion \(error.localizedDescription)")
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
        return String(format: "%.0f", min_Temperature)
    }
    
    /// Get max temperature
    var max_Temperature: String {
        let max_Temperature = weathercityModel.main.temp_max
        return String(format: "%.0f", max_Temperature)
    }
    
    /// Get himidity
    var humidityWeather: String {
        let humidity = weathercityModel.main.humidity
        return String("\(humidity)")
    }
    
    /// Get Feels Like
    var feelsLike: String {
        let feels = weathercityModel.main.feels_like
        return String(format: "%.0f", feels)
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
    /// Format date (e.g. Monday, May 11, 2020)
    private func dateFormatter(timeStamp: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateStyle = .long
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
    
    var date: String {
        return dateFormatter(timeStamp: weathercityModel.dt)
    }
}
