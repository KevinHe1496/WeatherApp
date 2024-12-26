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
    
    var weathercityModel = WeatherCityModel.init(weather: [], name: "", main: MainData(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, humidity: 0), sys: Sys(country: ""))
    
    var citySeached: String
    var cityName: String = ""
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    //    private var locationManager = CLLocationManager()
    
    @ObservationIgnored
    private var useCase: WeatherUseCaseProtocol
    
    
    init(useCase: WeatherUseCaseProtocol = WeatherUseCase(), citySeached: String = ""){
        self.useCase = useCase
        self.citySeached = citySeached
        //        locationManager.delegate = self
        //        locationManager.requestWhenInUseAuthorization()
        //        locationManager.requestLocation()
        
        //            await getCurrentWeatherLocation()
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
    
    //    @MainActor
    //    func getCurrentWeatherLocation() async {
    //        let data = await NetworkWeatherCity().fetchWeather(lat: latitude, lon: longitude)
    //        cityName = data.name
    //        weather = data.weather
    //        temperature = data.main.temp
    //        country = data.sys.country
    //        max_temperature = data.main.temp_max
    //        min_Temperature = data.main.temp_min
    //        humidity = data.main.humidity
    
    //    }
    
    //MARK: - CLLocationManagerDelegate
    
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        if let location = locations.last {
    //            longitude = location.coordinate.longitude
    //            latitude = location.coordinate.latitude
    //            Task {
    //                await NetworkWeatherCity().fetchWeather(lat: latitude, lon: longitude)
    //            }
    //
    //        }
    //    }
    //
    //    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
    //        print(error.localizedDescription)
    //    }
    
}
