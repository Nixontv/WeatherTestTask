//
//  WeatherModel.swift
//  WeatherTestTask
//
//  Created by Nikita Velichko on 06/02/23.
//

import Foundation

// MARK: - WeatherModel

struct WeatherModel: Codable {
    let timezone: String
    let current: Current
}

struct Current: Codable {
    let temp: Double
}
