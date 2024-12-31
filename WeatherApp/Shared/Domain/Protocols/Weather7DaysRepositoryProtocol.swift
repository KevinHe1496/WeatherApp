//
//  Weather7DaysRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import Foundation

///Protocol
protocol Weather7DaysRepositoryProtocol {
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather7DaysModel
}
