//
//  WeatherCityModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation

struct WeatherCityModel: Codable, Equatable {
    let coord: Coord
    let weather: [WeatherData]
    var dt: Int
    var name: String
    let main: MainData
    let sys: Sys
}

struct Coord: Codable, Equatable {
    let lon: Double
    let lat: Double
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
