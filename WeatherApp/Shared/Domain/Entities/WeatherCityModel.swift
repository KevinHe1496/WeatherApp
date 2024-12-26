//
//  WeatherCityModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation

struct WeatherCityModel: Codable, Equatable {
    let weather: [WeatherData]
    var name: String
    let main: MainData
    let sys: Sys
}

struct WeatherData: Codable, Identifiable, Equatable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainData: Codable, Equatable {
    let temp, feels_like, temp_min, temp_max: Double
    let humidity: Int
}

struct Sys: Codable, Equatable {
    let country: String
}
