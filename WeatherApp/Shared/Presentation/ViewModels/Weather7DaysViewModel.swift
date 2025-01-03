//
//  Weather7DaysViewModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import Foundation
import Combine

final class Weather7DaysViewModel: ObservableObject {
    
    
    @Published var weather7Days = Weather7DaysModel(list: [ListData(weather: [WeatherDataDays(id: 0, main: "", description: "")], main: MainDataDays(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, humidity: 0))], city: City(name: ""))
    
    @Published var status = Status.none
    @Published var cityname = ""

    private var useCase: Weather7DaysUseCaseProtocol
    
    init(useCase: Weather7DaysUseCaseProtocol = Weather7DaysUseCase()) {
        self.useCase = useCase
    }
    
    @MainActor
    func get7DaysWeather(lat: Double, lon: Double) async {
        
        do {
            let data = try await useCase.fetchWeather(lat: lat, lon: lon)
            self.weather7Days = data
            
        } catch {
            self.status = .error(error: "Error en obtener data weather7days\(error.localizedDescription)")
        }
    }

    public func dateFormatter(timeStamp: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
    
    var city: String {
        if let city = weather7Days.city.name {
            print(city)
            return city
        }
        return ""
    }
    
    var weatherDataDays: [WeatherDataDays] {
        if self.weather7Days.list.count != 0 {
            if let weatherdata = weather7Days.list[0].weather {
                return weatherdata
            }
        }
        return []
    }

}
