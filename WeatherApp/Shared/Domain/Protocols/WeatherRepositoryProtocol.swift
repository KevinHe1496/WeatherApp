//
//  WeatherRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation

/// Repository Protocol
protocol WeatherRepositoryProtocol {
    func fetchWeatherCity(city: String) async -> [WeatherData]
}
