//
//  AppState.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation
import Combine

@Observable
final class AppState{
    
    var status = Status.loading
    
    @ObservationIgnored
    private var weatherUseCase: WeatherUseCaseProtocol
    @ObservationIgnored
    private var locationManager: LocationManager
    
    init(weatherUseCase: WeatherUseCaseProtocol = WeatherUseCase(), locationManager: LocationManager = LocationManager()) {
        self.weatherUseCase = weatherUseCase
        self.locationManager = locationManager
        startLoadingView()
    }
    
    @MainActor
    func getWeather() {
        Task {
            do {
                let result = try await weatherUseCase.fetchWeather(lat: locationManager.userLatitude, lon: locationManager.userLongitude)
                if result.weather.isEmpty {
                    self.status = .error(error: "Error al cargar locacion")
                } else {
                    self.status = .loaded
                }
            } catch {
                self.status = .error(error: "Error al obtener la data: \(error.localizedDescription)")
            }
        }
    }
    
    func startLoadingView() {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.getWeather()
            }
        }
    }
    
}
