//
//  DetailForecastView.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 31/12/24.
//

import SwiftUI

struct DetailForecastView: View {
    
    var icon: String
    var date: String
    var temp: String
    var unit: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .frame(width: 30, height: 30)
            Text(date)
            HStack{
                Text(temp)
                Text(unit)
            }
            
        }
        .padding()
        .frame(width: 200, height: 130)
        .background(Color.secondary.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 10, x: 7, y: 7)
        .foregroundStyle(.white)
    }
}

#Preview {
    DetailForecastView(icon: "person",  date: "5 pm", temp: "11", unit: "°C")
}
