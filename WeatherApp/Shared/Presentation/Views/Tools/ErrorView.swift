//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Kevin Heredia on 3/1/25.
//

import SwiftUI

struct ErrorView: View {
    
    @Environment(AppState.self) var appState
    
    private var textError: String
    
    init(textError: String) {
        self.textError = textError
    }
    
    var body: some View {
        ZStack{
            Image("")
                .resizable()
                .background(Color.red)
            VStack {
                
                // Imagen error
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(.white)
                    .padding(.bottom)
                
                // Texto
                Text("OOOOPS!")
                    .font(.title)
                    .padding(.bottom, 50)
                    .foregroundStyle(.white)
                    .bold()
                Text("Algo salio mal.")
                    .foregroundStyle(.white)
                Text("Por favor intentalo de nuevo.")
                    .foregroundStyle(.white)
                    .padding(.bottom, 50)
                
                // Boton Regresar
                Button {
                    appState.status = .loading
                } label: {
                    Text("Regresar")
                        .font(.headline)
                        .foregroundStyle(.red)
                        .frame(width: 200, height: 50)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 7, x: 7, y: 7)
                }
            } // fin vstack
        }
    }
}

#Preview {
    ErrorView(textError: "Error de preview")
        .environment(AppState())
}
