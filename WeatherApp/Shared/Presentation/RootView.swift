//
//  RootView.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 24/12/24.
//

import SwiftUI

struct RootView: View {
    
    @Environment(AppState.self) var appState
    
    var body: some View {
        switch appState.status {

        case .loading:
            withAnimation {
                LoadingView()
            }
        case .loaded:
            withAnimation {
                WeatherView()
            }
        case .error(error: let errorString):
            withAnimation {
                ErrorView(textError: errorString)
            }
        }
    }
}

#Preview {
    RootView()
        .environment(AppState())
}
