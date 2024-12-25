//
//  MainRowView.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import SwiftUI

struct MainRowView: View {
    
    let weather: MainData
    
    var body: some View {
        VStack {
            Text("Max Temperature")
            Text("\(weather.temp_max)")
        }
    }
}

#Preview {
    MainRowView(weather: MainData(temp: 0.0, feels_like: 0.00, temp_min: 0.0, temp_max: 0.0, humidity: 5))
}
