//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 27/12/24.
//

import Foundation
import CoreLocation
import Combine


final class LocationManager: NSObject , @preconcurrency CLLocationManagerDelegate, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
    @Published var userLatitude: CLLocationDegrees = 0.0
    @Published var userLongitude: CLLocationDegrees = 0.0
    @Published var locationError: String = ""

    override init() {
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
        }
    }
    
    @MainActor
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
    self.locationError = "Error al obtener la ubicación: \(error.localizedDescription)"
    }

    

    
}
