//
//  Weather7DaysViewModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import Foundation

@Observable
final class Weather7DaysViewModel {
    
    var weather7Days = Weather7DaysModel(list: [ListData(weather: [WeatherDataDays(id: 1, main: "", description: "")], main: MainDataDays(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, humidity: 0))], city: City(name: ""))
    
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    var status = Status.none
    var locationManager = LocationManager()
    
    @ObservationIgnored
    private var useCase: Weather7DaysUseCaseProtocol
    
    init(useCase: Weather7DaysUseCaseProtocol = Weather7DaysUseCase()) {
        self.useCase = useCase
        Task {
            await get7DaysWeather()
        }
    }
    
   
    @MainActor
    func get7DaysWeather() async {
        self.status = .loading
        do {
            let data = try await useCase.fetchWeather(lat: locationManager.userLatitude, lon: locationManager.userLongitude)
            self.weather7Days = data
            self.status = .loaded
        } catch {
            print("Error en obtener la data")
        }
    }
    
}
