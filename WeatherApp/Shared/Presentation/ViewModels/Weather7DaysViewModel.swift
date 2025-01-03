//
//  Weather7DaysViewModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import Foundation
import Combine

final class Weather7DaysViewModel: ObservableObject {

    @Published var dataWeather7Days = Weather7DaysModel(city: City(name: ""), list: [ListData(weather: [WeatherDataDays(id: 0, main: "", description: "")], main: MainDataDays(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, humidity: 0))])
    
    @Published var status = Status.none
    @Published var cityName: String = ""
  
    private var useCase: Weather7DaysUseCaseProtocol
    private var locationManager = LocationManager()

    init(useCase: Weather7DaysUseCaseProtocol = Weather7DaysUseCase()) {
        self.useCase = useCase
    }
    
    
    //MARK: - Get 7 days Forecast for city
    @MainActor
    func getSevenDaysForecastCity(lat: Double, lon: Double) async {

        self.status = .loading
        do {
            dataWeather7Days = try await useCase.fetchWeather(lat: lat, lon: lon)
            cityName = dataWeather7Days.city.name
            self.status = .loaded
            
        } catch {
            self.status = .error(error: "Error en obtener el pronostico de 7 dias \(error.localizedDescription)")
        }
       
    }
    
    
    //MARK: - Get 7 days Forecast current Location
    @MainActor
    func getSevenDaysForecast() async {

        self.status = .loading
        do {
            dataWeather7Days = try await useCase.fetchWeather(lat: locationManager.userLatitude, lon: locationManager.userLongitude)
            cityName = dataWeather7Days.city.name
            self.status = .loaded
            
        } catch {
            self.status = .error(error: "Error en obtener el pronostico de 7 dias \(error.localizedDescription)")
        }
       
    }
    

    public func dateFormatter(timeStamp: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
}
