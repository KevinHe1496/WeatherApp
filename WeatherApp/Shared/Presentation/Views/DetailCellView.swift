//
//  DetailCellView.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 27/12/24.
//

import SwiftUI

struct DetailCellView: View {
    
    var icon: String
    var title: String
    var data: String
    var unit: String
    
    var body: some View {
        
        HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 33, weight: .thin))
                    .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 5.0) {
                    Text(title)
                        .foregroundColor(Color(#colorLiteral(red: 0.5607843137, green: 0.7411764706, blue: 0.9803921569, alpha: 1)))
                    HStack {
                        Text(data)
                            .font(.system(size: 21))
                            .bold()
                            .foregroundColor(.white)
                        Text(unit)
                            .font(.system(size: 14))
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
        
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
    }
}

#Preview {
    DetailCellView(icon: "thermometer.sun", title: "Humidity", data: "30.0", unit: "%")
}
