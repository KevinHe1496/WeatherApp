//
//  Weather7DaysModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import Foundation

struct Weather7DaysModel: Codable {
    let city: City
    var list: [ListData]
}

struct City: Codable {
    let name: String
}

struct ListData: Codable {
    var weather: [WeatherDataDays]
    let main: MainDataDays
    let dt_txt: String
}

struct WeatherDataDays: Codable, Identifiable, Hashable {
    let id: Int
    let main: String
    let description: String
}

struct MainDataDays: Codable {
    let temp, feels_like, temp_min, temp_max: Double
    let humidity: Int
}
