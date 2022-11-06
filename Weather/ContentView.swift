//
//  ContentView.swift
//  Weather
//
//  Created by Paul Quinnell on 2022-11-06.
//


import SwiftUI


struct ContentView: View {
    @StateObject private var forecastListVM = ForecastViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter Location", text: $forecastListVM.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        forecastListVM.getWeatherForcast()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title3)
                    }
                }
                List(forecastListVM.forecast, id: \.day) { day in
                        VStack(alignment: .leading) {
                            Text(day.day)
                                .fontWeight(.bold)
                            HStack(alignment: .top) {
                                Image(systemName: "hourglass")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(RoundedRectangle(cornerRadius:10).fill(Color.red))
                                VStack(alignment: .leading) {
                                    Text(day.overview)
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
            }
            .padding(.horizontal)
            .navigationTitle("Weather")
        }
    }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
	
