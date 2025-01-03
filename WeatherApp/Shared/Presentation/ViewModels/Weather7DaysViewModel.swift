//
//  Weather7DaysViewModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import Foundation
import Combine

final class Weather7DaysViewModel: ObservableObject {

    @Published var dataWeather7Days = Weather7DaysModel(city: City(name: ""), list: [ListData(weather: [WeatherDataDays(id: 0, main: "", description: "")], main: MainDataDays(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, humidity: 0), dt_txt: "")])
    
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
            print(dataWeather7Days)
            cityName = dataWeather7Days.city.name
            print(cityName)
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
    

    public func getTime(dateTime: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = formatter.date(from: dateTime) {
            formatter.dateFormat = "EEEE, HH:mm a"
            return formatter.string(from: date)
        } else {
            return "Formato no válido"
        }
    }
    
    var weather: [WeatherDataDays] {
        
        guard let fistListData = dataWeather7Days.list.first else {
            return []
        }
        return fistListData.weather
    }
    
    var getIcon: String {
        guard let weatherID = weather.first?.id else {
            return "questionmark"
        }
        return iconForWeatherID(weatherID)
    }
    
    private func iconForWeatherID(_ id: Int) -> String {
                switch id {
                case 200...232:
                    return "cloud.bolt.rain.fill"
                case 300...321:
                    return "cloud.drizzle.fill"
                case 500...531:
                    return "cloud.rain.fill"
                case 600...622:
                    return "cloud.snow.fill"
                case 701...781:
                    return "cloud.fog"
                case 801...804:
                    return "cloud.fill"
                default:
                    return "sun.max.fill"
                }
    }
    
    var temp: String {
        let temperature = dataWeather7Days.list[0].main.temp
        return String(format: "%.0f", temperature)
    }
}
