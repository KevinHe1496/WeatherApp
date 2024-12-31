//
//  Weather7DaysUseCase.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import Foundation

///Protocol
protocol Weather7DaysUseCaseProtocol {
    var repo: Weather7DaysRepositoryProtocol {get set}
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather7DaysModel
}

///Weather 7 days UseCase
final class Weather7DaysUseCase: Weather7DaysUseCaseProtocol {
    
    var repo: any Weather7DaysRepositoryProtocol
    
    init(repo: any Weather7DaysRepositoryProtocol = DefaultWeather7DaysRepository()) {
        self.repo = repo
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather7DaysModel {
        return try await repo.fetchWeather(lat: lat, lon: lon)
    }
}

///Weather 7 days UseCase Mock
final class Weather7DaysUseCaseMock: Weather7DaysUseCaseProtocol {
    
    var repo: any Weather7DaysRepositoryProtocol
    
    init(repo: any Weather7DaysRepositoryProtocol = DefaultWeather7DaysRepository(network: NetworkWeather7DaysMock())) {
        self.repo = repo
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather7DaysModel {
        return try await repo.fetchWeather(lat: lat, lon: lon)
    }
}
