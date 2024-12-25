//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import SwiftUI

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
                TextField("Search City", text: $viewModel.citySeached)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 350)
                    .onSubmit {
                        Task {
                            await viewModel.getWeather()
                        }
                    }
                    .padding(.bottom, 50)
                Text("\(viewModel.country)")
                    .font(.title)
                    .bold()
                    
                
                Text("\(viewModel.cityName)")
                    
                
                ForEach(viewModel.weather) { weather in
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")) { photo in
                        photo
                            .resizable()
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                
                Text(String(format: "%.0f °", viewModel.temperature))
                    .font(.system(size: 80))
                    .padding()
                
                
                LazyHGrid(rows: columns) {
                    ForEach(viewModel.weather) { weather in
                        Text("\(weather.main)")
                    }
                }
                
                Spacer()
            }
            
            .searchable(text: $viewModel.cityName)
            
        }
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel(citySeached: "New york"))
}
