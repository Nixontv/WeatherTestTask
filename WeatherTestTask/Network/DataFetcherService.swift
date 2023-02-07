//
//  DataFetcherService.swift
//  WeatherTestTask
//
//  Created by Nikita Velichko on 06/02/23.
//

import Foundation
import CoreLocation


class DataFetcherManager {
    static let shared = DataFetcherManager()
    
    var networkDataFetcher: DataFetcher = NetworkDataFetcher()
    var weatherData: WeatherModel?
    
    func fetchWeatherData (latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = APIManager.shared.getLocationCurrentWeatherURL(latitude: latitude, longitude: longitude)
        networkDataFetcher.fetchData(urlString: urlString) { [weak self] model in
            guard let self = self else { return }
            self.weatherData = model
            NotificationCenter.default.post(name: Notification.Name("DataUploaded"), object: nil)
        }
    }
}
