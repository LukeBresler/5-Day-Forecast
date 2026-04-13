//
//  WeatherView.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            if let currentWeather = viewModel.weatherData.first {
                
                let weatherStyle = WeatherBackground()
                    .style(for: currentWeather.weather.first?.main ?? "")
                
                VStack {
                    ZStack {
                        HStack {
                            weatherStyle.backgroundImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .ignoresSafeArea(.all)
                        }
                        VStack {
                            Spacer()
                            
                            HStack {
                                Text("5 Day Forecast")
                                    .font(.custom("Poppins-Bold", size: 18))
                                    .foregroundStyle(Color.white)
                                    .padding(.leading, 10)
                                    .padding(.all, 10)
                                Spacer()
                            }
                            
                            Divider()
                                .frame(height: 2)
                                .background(Color.white)
                            
                            ScrollView {
                                ForecastListView(weatherData: ForecastGrouper.getDailyForecasts(from: viewModel.weatherData))
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 30)
                            
                        }
                        .padding(.top, 30)
                        .ignoresSafeArea(.all)
                    }
                }
            } else {
                LoadingView(errorMessage: viewModel.errorMessage) {
                    viewModel.requestLocation()
                }
            }
        }
        .onAppear {
            viewModel.requestLocation()
        }
    }
}