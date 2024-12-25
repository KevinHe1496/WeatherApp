//
//  DefaultWeatherReporitory.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation

///Default Weather Repository
final class DefaultWeatherReporitory: WeatherRepositoryProtocol {
    
    private var network: NetworkWeatherCityProtocol
    
    init(network: NetworkWeatherCityProtocol = NetworkWeatherCity()) {
        self.network = network
    }
    
    func fetchWeatherCity(city: String) async -> WeatherCityModel {
        return await network.fetchWeatherCity(city: city)
    }
}

/// Mock
final class DefaultWeatherReporitoryMock: WeatherRepositoryProtocol {
    
    private var network: NetworkWeatherCityProtocol
    
    init(network: NetworkWeatherCityProtocol = NetworkWeatherCityMock()) {
        self.network = network
    }
    
    func fetchWeatherCity(city: String) async -> WeatherCityModel {
        return await network.fetchWeatherCity(city: city)
    }
    
    
}
