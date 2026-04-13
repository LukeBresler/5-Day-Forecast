//
//  LoadingView.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import SwiftUI

struct LoadingView: View {
    let errorMessage: String?
    let retryAction: () -> Void
    
    var body: some View {
        ZStack {
            Image("loadingScreen")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(spacing: 20) {
                if let error = errorMessage {
                    Text("Error")
                        .font(.headline)
                        .foregroundColor(.red)
                    Text(error)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.white)
                    
                    Button("Retry") {
                        retryAction()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                } else {
                    ProgressView("Loading weather data...")
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}
