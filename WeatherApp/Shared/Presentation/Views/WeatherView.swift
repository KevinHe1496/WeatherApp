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
    @State var searchField = ""
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ZStack {
            Image("")
                .resizable()
            LinearGradient(colors: [Color(red: 22/255, green: 106/255, blue: 215/255), Color(red: 139/255, green: 133/255, blue: 254/255), Color(red: 94/255, green: 129/255, blue: 254/255)], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()

            VStack {
                
                // TextField
                HStack {
                    TextField("Search City", text: $viewModel.citySeached)
                        
                        .frame(width: 270)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            Task {
                                await viewModel.getWeather()
                            }
                        }
                    // Clear Button
                    Button("Cancel") {
                        viewModel.citySeached = ""
                    }
                    .foregroundStyle(.white)
                    .frame(width: 80, height: 35)
                    .background(Color.secondary.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                }
                
                Spacer()
                
                // Country Name
                
                Text(viewModel.countryName)
                    .font(.system(size: 80))
                    .bold()
                    .foregroundStyle(.white)
  
                // City Name
                Text("\(viewModel.weathercityModel.name)")
                    .font(.title)
                    .foregroundStyle(.white)
                
                // Date
                Text(viewModel.date)
                    .padding(.bottom)
                    .foregroundStyle(.white)
                
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
                    .foregroundStyle(.white)

                // Temperatures
                HStack(spacing: 40) {
                    VStack(spacing: 5){
                        Image(systemName: "arrow.up.circle")
                            .font(.system(size: 35))
                        Text("Max")
                        Text(viewModel.max_Temperature)
                    }
                    
                    Divider().frame(height: 50).background(.white)
                    
                    VStack(spacing: 5){
                        Image(systemName: "arrow.down.circle")
                            .font(.system(size: 35))
                        Text("Min")
                        Text(viewModel.min_Temperature)
                    }
                    Divider().frame(height: 50).background(.white)
 
                    VStack(spacing: 5){
                        Image(systemName: "thermometer.sun")
                            .font(.system(size: 35))
                        Text("Humidity")
                        Text(viewModel.humidityWeather)
                    }
                    
                    
                    
                }
                .padding(20)
                .foregroundStyle(.white)
                .background(Color.secondary.opacity(0.3))
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
