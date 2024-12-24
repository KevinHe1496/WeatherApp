//
//  WeatherCityModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation

struct WeatherCityModel: Codable {
    let weather: [WeatherData]
}

struct WeatherData: Codable, Identifiable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
