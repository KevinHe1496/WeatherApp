//
//  NetworkWeatherCity.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation

/// Protocol
protocol NetworkWeatherCityProtocol {
    func fetchWeatherCity(city: String) async -> [WeatherData]
}

/// Network Weather
final class NetworkWeatherCity: NetworkWeatherCityProtocol {
    
    func fetchWeatherCity(city: String) async -> [WeatherData] {
        
        var modelReturn = [WeatherData]()
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.weatherCity)?q=\(city)&appid=\(ConstantsApp.CONS_APIKEY)"
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpRes = response as? HTTPURLResponse {
                if httpRes.statusCode == HttpResponseCodes.SUCCESS {
                    let weatherData = try JSONDecoder().decode(WeatherCityModel.self, from: data)
                    modelReturn = weatherData.weather
                }
            }
        } catch {
            NSLog("Error en obtener clima: \(error.localizedDescription)")
        }
        return modelReturn
    }
    
    
}
