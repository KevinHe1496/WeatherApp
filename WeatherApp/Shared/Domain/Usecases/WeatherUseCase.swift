//
//  WeatherUseCase.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation

///Protocol
protocol WeatherUseCaseProtocol {
    
    var repo: WeatherRepositoryProtocol {get set}
    func fetchWeatherCity(city: String) async -> WeatherCityModel
    
}

/// Weather UseCase
final class WeatherUseCase: WeatherUseCaseProtocol {
    
    var repo: WeatherRepositoryProtocol
    
    init(repo: WeatherRepositoryProtocol = DefaultWeatherReporitory(network: NetworkWeatherCity())) {
        self.repo = repo
    }
    
    func fetchWeatherCity(city: String = "") async -> WeatherCityModel {
        return await repo.fetchWeatherCity(city: city)
    }
}


/// Mock
final class WeatherUseCaseMock: WeatherUseCaseProtocol {
    
    var repo: WeatherRepositoryProtocol
    
    init(repo: WeatherRepositoryProtocol = DefaultWeatherReporitory(network: NetworkWeatherCityMock())) {
        self.repo = repo
    }
    
    func fetchWeatherCity(city: String) async -> WeatherCityModel {
        return await repo.fetchWeatherCity(city: city)
    }
}

