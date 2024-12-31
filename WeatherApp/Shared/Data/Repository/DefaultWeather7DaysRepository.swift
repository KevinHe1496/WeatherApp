//
//  DefaultWeather7DaysRepository.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import Foundation

///Default weather 7 days
final class DefaultWeather7DaysRepository: Weather7DaysRepositoryProtocol {
    
    private var network: NetworkWeather7DaysProtocol
    
    init(network: NetworkWeather7DaysProtocol = NetworkWeather7Days()) {
        self.network = network
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather7DaysModel {
        return try await network.fetchWeather(lat: lat, lon: lon)
    }
}

///Default weather 7 days Mock
final class DefaultWeather7DaysRepositoryMock: Weather7DaysRepositoryProtocol {
    
    private var network: NetworkWeather7DaysProtocol
    
    init(network: NetworkWeather7DaysProtocol = NetworkWeather7DaysMock()) {
        self.network = network
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather7DaysModel {
        return try await network.fetchWeather(lat: lat, lon: lon)
    }
}
