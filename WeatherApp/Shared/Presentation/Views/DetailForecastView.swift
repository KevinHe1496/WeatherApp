//
//  DetailForecastView.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import SwiftUI

struct DetailForecastView: View {
    
    var day: String
    var icon: String
    var temp: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(day)
            Image(systemName: icon)
                .font(.system(size: 30))
            Text(temp)
            
        }
    }
}

#Preview {
    DetailForecastView(day: "Monday", icon: "person", temp: "11 °C")
}
