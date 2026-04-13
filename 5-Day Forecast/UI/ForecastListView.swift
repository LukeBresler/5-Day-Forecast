//
//  ForecastListView.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import SwiftUI

struct ForecastListView: View {
    let weatherData: [WeatherData]
    
    var body: some View {
        VStack(spacing: 18) {
            ForEach(weatherData) { weather in
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(DateFormatterUtility.getDayOfWeek(from: weather.date))
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundColor(.black)
                        
                        HStack {
                            HStack {
                                WeatherIconProvider.weatherIcon(for: weather.weather.first?.main ?? "")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            }
                            Spacer()
                            
                            Text("\(Int(weather.main.temp))°")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                }
                .frame(height: 125)
                .padding(.horizontal)
            }
        }
    }
}