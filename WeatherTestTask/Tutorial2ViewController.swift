//
//  Tutorial2ViewController.swift
//  WeatherTestTask
//
//  Created by Nikita Velichko on 06/02/23.
//

import UIKit
import CoreLocation
class Tutorial2ViewController: UIViewController {
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationPermission()
        NotificationCenter.default.addObserver(self, selector: #selector(dataUploaded), name: Notification.Name("DataUploaded"), object: nil)
    }
    
    @objc func dataUploaded() {
        print("DataUploaded")
    }
    
    func checkLocationPermission() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

}

extension Tutorial2ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        if DataFetcherManager.shared.weatherData == nil {
            DataFetcherManager.shared.fetchWeatherData(latitude: latitude, longitude: longitude)
        }
    }
}
