//
//  WeatherRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation
import CoreLocation

/// Repository Protocol
protocol WeatherRepositoryProtocol {
    func fetchWeatherCity(city: String) async throws -> WeatherCityModel
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> WeatherCityModel
}
