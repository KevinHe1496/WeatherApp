//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 3/1/25.
//

import SwiftUI

struct LoadingView: View {
    
    @Environment(AppState.self) var appState
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 22/255, green: 106/255, blue: 215/255), Color(red: 139/255, green: 133/255, blue: 254/255), Color(red: 94/255, green: 129/255, blue: 254/255)], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack {
                //Progress
                ProgressView()
                    .tint(.white)
                    .scaleEffect(1.5)
                    .padding()
                // Animación texto
                Text("Cargando...")
                    .opacity(isAnimating ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: isAnimating)
            }
            .foregroundStyle(.white)
            .onAppear {
                isAnimating = true
            }
        }
    }
}

#Preview {
    LoadingView()
        .environment(AppState())
}
