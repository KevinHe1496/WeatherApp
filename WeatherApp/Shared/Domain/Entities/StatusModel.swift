//
//  StatusModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation

/// Estados de la aplicación
enum Status {
    case none, loading, loaded, error(error: String)
}
