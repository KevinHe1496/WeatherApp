//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    
    @State var viewModel: WeatherViewModel
    let columns = Array(repeating: GridItem(.flexible(minimum: 20)), count: 1)
    let network = NetworkWeatherCity()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ZStack {
            Image("")
                .resizable()
                .background(Color(red: 192/255, green: 196/255, blue: 201/255))
            VStack {
                
                // TextField
                TextField("Search City", text: $viewModel.citySeached)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 350)
                    .onSubmit {
                        Task {
                            await viewModel.getWeather()
                        }
                    }
                
                Spacer()
                
                // Country Name
                
                Text(viewModel.countryName)
                    .font(.system(size: 80))
                    .bold()
                
                
                
                // City Name
                Text("\(viewModel.weathercityModel.name)")
                
                // Icon
                Image(systemName: viewModel.getIcon)
                    .font(.system(size: 150))
                    .foregroundStyle(.white)
                
                // Temperature
                Text(viewModel.temperature)
                    .font(.system(size: 80))
                
                // Description
                
                Text("\(viewModel.weatherDescription)")
                
                
                // Temperatures
                
                HStack {
                    VStack{
                        Text("Max")
                        Text(viewModel.max_Temperature)
                    }
                    .padding()
                    .border(FillShapeStyle())
                    
                    VStack{
                        Text("Min")
                        Text(viewModel.min_Temperature)
                    }
                    .padding()
                    .border(FillShapeStyle())
                    VStack{
                        Text("Humidity")
                        Text(viewModel.humidityWeather)
                        
                    }
                    .padding()
                    .border(FillShapeStyle())
                }
                
                Spacer()
            }
            
            .searchable(text: $viewModel.cityName)
            
        }
        
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel(citySeached: "Quito"))
}
