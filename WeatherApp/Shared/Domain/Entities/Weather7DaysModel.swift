//
//  Weather7DaysModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import Foundation

struct Weather7DaysModel: Codable {
    let list: [ListData]
    let city: City
}

struct City: Codable {
    let name: String
}

struct ListData: Codable {
    let weather: [WeatherDataDays]
    let main: MainDataDays
}

struct WeatherDataDays: Codable, Identifiable {
    let id: Int
    let main: String
    let description: String
}

struct MainDataDays: Codable {
    let temp, feels_like, temp_min, temp_max: Double
    let humidity: Int
}
