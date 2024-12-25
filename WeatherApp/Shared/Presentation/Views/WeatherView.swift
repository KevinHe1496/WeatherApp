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
                Text("\(viewModel.country)")
                    .font(.system(size: 80))
                    .bold()
                    
                // City Name
                Text("\(viewModel.cityName)")
                
                // Image
                ForEach(viewModel.weather) { weather in

                    Image(systemName: viewModel.getIcon)
                        .font(.system(size: 150))
                        .foregroundStyle(.white)
                }
                .padding()

                // Temperature
                Text(String(format: "%.0f °", viewModel.temperature))
                    .font(.system(size: 80))

                // Forecast
                    ForEach(viewModel.weather) { weather in
                        Text("\(weather.main)")
                    }

                // Temperatures
                
                HStack {
                    VStack{
                        Text("Max")
                        Text(String(format: "%.0f °", viewModel.max_temperature))
                    }
                    .padding()
                    .border(FillShapeStyle())
                
                    VStack{
                        Text("Min")
                        Text(String(format: "%.0f °", viewModel.min_Temperature))
                    }
                    .padding()
                    .border(FillShapeStyle())
                    VStack{
                        Text("Humedad")
                        Text("\(viewModel.humidity)")
                            
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
