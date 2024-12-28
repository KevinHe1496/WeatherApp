//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 27/12/24.
//

import Foundation
import CoreLocation
import Combine

@Observable
final class LocationManager: NSObject , @preconcurrency CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var dataLocation: WeatherCityModel?
    var status = Status.none
    var userLatitude: CLLocationDegrees = 0.0
    var userLongitude: CLLocationDegrees = 0.0
    var locationError: String = ""
    
    @ObservationIgnored
    private var useCaseLocations: WeatherUseCaseProtocol
    
    init(useCaseLocations: WeatherUseCaseProtocol = WeatherUseCase()) {
        self.useCaseLocations = useCaseLocations
        super.init()
        locationConfiguration()
    }
    
    private func locationConfiguration() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        switch locationManager.authorizationStatus {
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                case .authorizedWhenInUse, .authorizedAlways:
                    locationManager.startUpdatingLocation()
                case .denied, .restricted:
                    self.locationError = "Por favor habilita los permisos de ubicación en Configuración."
                @unknown default:
                    break
                }
    }
    
    
    //MARK: - CLLocationManagerDelegate
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
                self.userLongitude = location.coordinate.longitude
                self.userLatitude = location.coordinate.latitude

            Task(priority: .high) {
                await getCurrentLocation(lat: self.userLatitude, lon: self.userLongitude)
            }
            
        }
    }
    
    @MainActor
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
    
    self.locationError = "Error al obtener la ubicación: \(error.localizedDescription)"
        
    }
    
    //MARK: - Get Current Location
    
    @MainActor
    func getCurrentLocation(lat: CLLocationDegrees, lon: CLLocationDegrees) async {
        self.status = .loading
        
        let data = await useCaseLocations.fetchWeather(lat: lat, lon: lon)
        
        self.dataLocation = data
        self.status = .loaded
    }
    

    
}
