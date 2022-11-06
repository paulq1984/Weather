//
//  ForecastListViewModel.swift
//  Weather
//
//  Created by Paul Quinnell on 2022-11-06.
//
import CoreLocation
import Foundation

class ForecastListViewModel: ObservableObject {
    @Published var forecasts: [ForecastViewModel] = []
    var location: String = ""
    
    func getWeatherForcast() {
        let apiService = APIService.shared
        
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                apiService.getJSON(urlString:"https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=6a7831ae03e358a1861c15a2f89ce57a", dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast,APIService.APIError>)
                    in
                    switch result {
                    case .success(let forecast):
                        DispatchQueue.main.async {
                            self.forecasts = forecast.daily.map { ForecastViewModel(forecast: $0)}
                        }
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                        }
                    }
                    
                }
            }
        }

    }
}
