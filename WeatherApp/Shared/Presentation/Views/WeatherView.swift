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
                    .font(.title)
                
                // Date
                Text(viewModel.date)
                    .padding(.bottom)
                
                // Icon
                Image(systemName: viewModel.getIcon)
                    .font(.system(size: 150))
                    .foregroundStyle(.white)
                    .shadow(radius: 10, x: 7, y: 7)
                
                // Description
                Text("\(viewModel.weatherDescription)")
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.bottom)
                
                // Temperature
                Text(viewModel.temperature)
                    .font(.system(size: 80))
                    .bold()

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
                .background()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 10, x: 7, y: 7)
                
                
                Spacer()
            }
            
            .searchable(text: $viewModel.cityName)
            
        }
        
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel(citySeached: "Quito"))
}
