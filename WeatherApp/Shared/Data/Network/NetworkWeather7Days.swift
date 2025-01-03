//
//  NetworkWeather7Days.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import Foundation

///Protocol
protocol NetworkWeather7DaysProtocol {
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather7DaysModel
}

///Network
final class NetworkWeather7Days: NetworkWeather7DaysProtocol {
    
    let urlWeather = "\(ConstantsApp.CONS_API_URL)\(EndPoints.weatherFor7Days)?appid=\(ConstantsApp.CONS_APIKEY)&units=metric"
    
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather7DaysModel {
        
        let urlString = "\(urlWeather)&lat=\(lat)&lon=\(lon)"
        
        guard let url = URL(string: urlString) else {
            throw ErrorApp.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ErrorApp.invalidResponse
            }
            
            guard httpResponse.statusCode == HttpResponseCodes.SUCCESS else {
                throw ErrorApp.errorFromApi(statusCode: httpResponse.statusCode)
            }
            
            let resultData = try JSONDecoder().decode(Weather7DaysModel.self, from: data)
            
            return resultData
        } catch {
            throw ErrorApp.errorParsingData
        }   
    }
}

///Mock
final class NetworkWeather7DaysMock: NetworkWeather7DaysProtocol {
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather7DaysModel {
        
        let model1 = Weather7DaysModel(city: City(name: "Quito"), list: [ListData(weather: [WeatherDataDays(id: 1, main: "Cloudy", description: "light rain")], main: MainDataDays(temp: 10.52, feels_like: 8.00, temp_min: 3.52, temp_max: 15.5, humidity: 50), dt_txt: "")])
        
        return model1
    }
  
}
