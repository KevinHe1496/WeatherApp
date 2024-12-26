//
//  ErrorApp.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 25/12/24.
//

import Foundation

enum ErrorApp: Error, CustomStringConvertible {
    
    case requestWasNil
    case errorFromServer(reason: Error)
    case errorFromApi(statusCode: Int)
    case dataNoReveiced
    case errorParsingData
    case invalidResponse
    case badUrl
    
    
    var description: String {
        switch self {
            
        case .requestWasNil:
            return "Error creating request"
        case .errorFromServer(reason: let reason):
            return "Received error from server \((reason as NSError).code)"
        case .errorFromApi(statusCode: let statusCode):
            return "Received error from api status code \(statusCode)"
        case .dataNoReveiced:
            return "Data no received from server"
        case .errorParsingData:
            return "There was un error parsing data"
        case .badUrl:
            return "Bad url"
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}
