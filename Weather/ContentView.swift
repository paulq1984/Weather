//
//  ContentView.swift
//  Weather
//
//  Created by Paul Quinnell on 2022-11-06.
//

import SDWebImageSwiftUI
import SwiftUI


struct ContentView: View {
    @StateObject private var forecastListVM = ForecastListViewModel()
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Picker(selection: $forecastListVM.system, label: Text("System")) {
                        Text("°C").tag(0)
                        Text("°F").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                    .padding(.vertical)
                    HStack {
                        TextField("Enter Location", text: $forecastListVM.location,
                                  onCommit: {
                            forecastListVM.getWeatherForcast()
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(
                            Button(action: {
                                forecastListVM.location = ""
                                forecastListVM.getWeatherForcast()
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.gray)
                            }
                                .padding(.horizontal),
                            alignment: .trailing
                        )
                        Button {
                            forecastListVM.getWeatherForcast()
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.title3)
                        }
                    }
                    List(forecastListVM.forecasts, id: \.day) { day in
                        VStack(alignment: .leading) {
                            Text(day.day)
                                .fontWeight(.bold)
                            HStack(alignment: .center) {
                                WebImage(url: day.weatherIconUrl)
                                    .resizable()
                                    .placeholder {
                                        Image(systemName: "hourglass")
                                    }
                                    .scaledToFit()
                                    .frame(width: 75)
                                VStack(alignment: .leading) {
                                    Text(day.overview)
                                        .font(.title2)
                                    HStack {
                                        Text(day.high)
                                        Text(day.low)
                                    }
                                    
                                    HStack {
                                        Text(day.clouds)
                                        Text(day.pop)
                                    }
                                    
                                    Text(day.humidity)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                .padding(.horizontal)
                .navigationTitle("Weather")
                .alert(item: $forecastListVM.appError) { appAlert in
                    Alert(title: Text("Error"),
                          message: Text("""
                                \(appAlert.errorString)
                                Please trasy again later
                                """
                                       )
                    )
                }
            }
            if forecastListVM.isLoading {
                ZStack {
                    Color(.white)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView("Fetching Weather")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemBackground))
                        )
                        .shadow(radius: 10)
                }
            }
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

