//
//  WeatherUseCase.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation
import CoreLocation

///Protocol
protocol WeatherUseCaseProtocol {
    
    var repo: WeatherRepositoryProtocol {get set}
    func fetchWeatherCity(city: String) async throws -> WeatherCityModel
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> WeatherCityModel
    
}

/// Weather UseCase
final class WeatherUseCase: WeatherUseCaseProtocol {

    var repo: WeatherRepositoryProtocol
    
    init(repo: WeatherRepositoryProtocol = DefaultWeatherReporitory(network: NetworkWeatherCity())) {
        self.repo = repo
    }
    
    func fetchWeatherCity(city: String = "") async throws -> WeatherCityModel {
        return try await repo.fetchWeatherCity(city: city)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws-> WeatherCityModel {
        return try await repo.fetchWeather(lat: lat, lon: lon)
    }
    
}


/// Mock
final class WeatherUseCaseMock: WeatherUseCaseProtocol {
    
    var repo: WeatherRepositoryProtocol
    
    init(repo: WeatherRepositoryProtocol = DefaultWeatherReporitory(network: NetworkWeatherCityMock())) {
        self.repo = repo
    }
    
    func fetchWeatherCity(city: String) async throws -> WeatherCityModel {
        return try await repo.fetchWeatherCity(city: city)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> WeatherCityModel {
        return try await repo.fetchWeather(lat: lat, lon: lon)
    }
    
}

