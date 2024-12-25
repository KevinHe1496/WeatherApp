//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import Foundation
import Combine
import CoreLocation

@Observable
final class WeatherViewModel: NSObject, CLLocationManagerDelegate {
  
    var citySeached: String
    var cityName: String = ""
    var weather = [WeatherData]()
    var temperature: Double = 0.0
    var country: String = ""
    var icon: String = ""
    let conditionID = 0
    var max_temperature: Double = 0.0
    var min_Temperature: Double = 0.0
    var humidity: Int = 0
    var id: Int = 0
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    private var locationManager = CLLocationManager()
    
    @ObservationIgnored
    private var useCase: WeatherUseCaseProtocol
    
    
    init(useCase: WeatherUseCaseProtocol = WeatherUseCase(), citySeached: String = "") {
        self.useCase = useCase
        self.citySeached = citySeached
        
        super.init()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        Task {
            await getWeather()
            await getCurrentWeatherLocation()
        }
        
    }
    
    var getIcon: String {
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
    
    
    
    @MainActor
    func getWeather() async {
        let data = await useCase.fetchWeatherCity(city: citySeached)
        cityName = data.name
        weather = data.weather
        temperature = data.main.temp
        country = data.sys.country
        max_temperature = data.main.temp_max
        min_Temperature = data.main.temp_min
        humidity = data.main.humidity
        id = weather[0].id
    }
    
    @MainActor
    func getCurrentWeatherLocation() async {
        let data = await NetworkWeatherCity().fetchWeather(lat: latitude, lon: longitude)
        cityName = data.name
        weather = data.weather
        temperature = data.main.temp
        country = data.sys.country
        max_temperature = data.main.temp_max
        min_Temperature = data.main.temp_min
        humidity = data.main.humidity
        id = weather[0].id
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
            Task {
                await NetworkWeatherCity().fetchWeather(lat: latitude, lon: longitude)
            }

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
    
}
