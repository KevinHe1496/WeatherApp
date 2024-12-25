//
//  NetworkWeatherCity.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation

/// Protocol
protocol NetworkWeatherCityProtocol {
    func fetchWeatherCity(city: String) async -> WeatherCityModel
}

/// Network Weather
final class NetworkWeatherCity: NetworkWeatherCityProtocol {
    
    func fetchWeatherCity(city: String) async -> WeatherCityModel {
        
        var modelReturn = WeatherCityModel(weather: [WeatherData(id: 0, main: "...", description: "...", icon: "...")], name: "...", main: MainData(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, humidity: 0), sys: Sys(country: "..."))
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.weatherCity)?q=\(city)&appid=\(ConstantsApp.CONS_APIKEY)&units=metric"
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpRes = response as? HTTPURLResponse {
                if httpRes.statusCode == HttpResponseCodes.SUCCESS {
                    let weatherData = try JSONDecoder().decode(WeatherCityModel.self, from: data)
                    modelReturn = weatherData
                }
            }
        } catch {
            NSLog("Error en obtener clima: \(error.localizedDescription)")
        }
        return modelReturn
    }
}

/// Mock
final class NetworkWeatherCityMock: NetworkWeatherCityProtocol {
    func fetchWeatherCity(city: String) async -> WeatherCityModel {
        
        let model1 = WeatherCityModel(weather: [WeatherData(id: 1, main: "Cloudy", description: "light rain", icon: "300d")], name: "Quito", main: MainData(temp: 10.52, feels_like: 8.00, temp_min: 3.52, temp_max: 15.5, humidity: 90), sys: Sys(country: "Ecuador"))
        
        return model1
    }
}
