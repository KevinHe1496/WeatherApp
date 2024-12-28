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
            // Background
            LinearGradient(colors: [Color(red: 22/255, green: 106/255, blue: 215/255), Color(red: 139/255, green: 133/255, blue: 254/255), Color(red: 94/255, green: 129/255, blue: 254/255)], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    
                    
                    HStack {
                        // Current location Button
                        Button {
                            Task {
                                await viewModel.getCurrentLocation()
                            }
                            viewModel.citySeached = ""
                        } label: {
                            Image(systemName: "location.fill")
                                .font(.system(size: 21))
                                .foregroundStyle(.white)
                                .shadow(color: Color.black.opacity(0.20), radius: 5, x: 0, y: 6)
                                .frame(width: 40, height: 35)
                                .background(Color.secondary.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                        }
                        
                        // TextField Search City
                        TextField("Search City", text: $viewModel.citySeached)
                        
                            .frame(width: 230)
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
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    
                    Spacer()
                    // Country Name
                    Text(viewModel.countryName)
                        .font(.system(size: 50))
                        .bold()
                        .foregroundStyle(.white)
                        .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                    
                    
                    HStack(spacing: 30) {
                        // Icon
                        Image(systemName: viewModel.getIcon)
                            .font(.system(size: 100))
                            .foregroundStyle(.white)
                            .shadow(radius: 10, x: 7, y: 7)
                            .frame(width: 100, height: 100)
                            .padding(.top)
                            .padding(.bottom)
                        // Description
                        VStack(alignment: .trailing, spacing: 5) {
                            Text("\(viewModel.weatherDescription)")
                                .font(.system(size: 25))
                                .foregroundStyle(.white)
                                .bold()
                            // City Name
                            Text("\(viewModel.weathercityModel.name)")
                                .foregroundStyle(.white)
                            // Date
                            Text(viewModel.date)
                                .foregroundStyle(.white)
                        }
                        .frame(width: 190)
                        .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                        
                    }
                 
                    
                    // Temperature
                    Text(viewModel.temperature)
                        .font(.system(size: 80))
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top)
                        .padding(.bottom)
                        .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                    
                    // Temperatures
                    VStack(spacing: 47) {
                        HStack(spacing: 20){
                            DetailCellView(icon: "arrow.up.circle", title: "Max Temp", data: viewModel.max_Temperature, unit: "°C")
                            Divider().frame(height: 40).background(.white)
                            DetailCellView(icon: "arrow.down.circle", title: "Min Temp", data: viewModel.min_Temperature, unit: "°C")
                        }
                        
                        HStack(spacing: 20){
                            DetailCellView(icon: "thermometer.sun", title: "Humidity", data: viewModel.humidityWeather, unit: "%")
                            Divider().frame(height: 40).background(.white)
                            DetailCellView(icon: "heart", title: "Feels Like", data: viewModel.feelsLike, unit: "°C")
                        }
                        
                    }
                    .padding()
                    .background(Color.secondary.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 10, x: 7, y: 7)
                    
                    Spacer()
                }
                
                .searchable(text: $viewModel.cityName)
                
            }
            
            .padding(.top)
            .ignoresSafeArea(edges: .horizontal)
            
        } // Fin zStack

        .onAppear {
            Task {
                await viewModel.getCurrentLocation()
            }
            
        }
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel(citySeached: "Quito"))
}
