//
//  WeatherViewController.swift
//  WeatherTestTask
//
//  Created by Nikita Velichko on 06/02/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    var loadingView = LoadViewController()
    
    // MARK: - IBOutlets
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLoadingView()
        setupLocationManager()
        NotificationCenter.default.addObserver(self, selector: #selector(dataUploaded), name: Notification.Name("DataUploaded"), object: nil)
    }
    
    @objc func dataUploaded() {
        if DataFetcherManager.shared.weatherData != nil {
            guard let temp = DataFetcherManager.shared.weatherData?.current.temp,
                  let city = DataFetcherManager.shared.weatherData?.timezone.deletingPrefix() else { return }
            
            self.infoLabel.text = "\(temp) degrees in \(city)"
            self.removeLoadingView()
        }
    }
    
    private func addLoadingView() {
        if DataFetcherManager.shared.weatherData == nil {
            loadingView = LoadViewController()
            view.addSubview(loadingView.view)
            self.loadingView.view.alpha = 1
            self.loadingView.view.frame = self.view.bounds
        }
    }
    
    private func removeLoadingView() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.7) {
                self.loadingView.view.alpha = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadingView.view.removeFromSuperview()
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        if DataFetcherManager.shared.weatherData == nil {
            DataFetcherManager.shared.fetchWeatherData(latitude: latitude, longitude: longitude)
        } else {
            guard let temp = DataFetcherManager.shared.weatherData?.current.temp,
                  let city = DataFetcherManager.shared.weatherData?.timezone.deletingPrefix() else { return }
            
            self.infoLabel.text = "\(temp) degrees in \(city)"
        }
    }
}
