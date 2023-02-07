//
//  Tutorial1ViewController.swift
//  WeatherTestTask
//
//  Created by Nikita Velichko on 06/02/23.
//

import UIKit
import CoreLocation

class Tutorial1ViewController: UIViewController {
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationPermission()
    }
    
    func checkLocationPermission() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

}

extension Tutorial1ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
            // Show alert to turn on location in settings
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                nextButton.sendActions(for: .touchUpInside)
            @unknown default:
                break
        }
    }
}
