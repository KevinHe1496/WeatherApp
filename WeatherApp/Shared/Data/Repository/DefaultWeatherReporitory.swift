//
//  DefaultWeatherReporitory.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation
import CoreLocation

///Default Weather Repository
final class DefaultWeatherReporitory: WeatherRepositoryProtocol {
    
    
    
    private var network: NetworkWeatherCityProtocol
    
    init(network: NetworkWeatherCityProtocol = NetworkWeatherCity()) {
        self.network = network
    }
    
    func fetchWeatherCity(city: String) async throws -> WeatherCityModel {
        return try await network.fetchWeatherCity(city: city)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) async -> WeatherCityModel {
        return await network.fetchWeather(lat: lat, lon: lon)
    }
}

/// Mock
final class DefaultWeatherReporitoryMock: WeatherRepositoryProtocol {
    
    private var network: NetworkWeatherCityProtocol
    
    init(network: NetworkWeatherCityProtocol = NetworkWeatherCityMock()) {
        self.network = network
    }
    
    func fetchWeatherCity(city: String) async throws -> WeatherCityModel {
        return try await network.fetchWeatherCity(city: city)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) async -> WeatherCityModel {
        return await network.fetchWeather(lat: lon, lon: lat)
    }
  
}
