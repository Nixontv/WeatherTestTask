//
//  Extensions.swift
//  WeatherTestTask
//
//  Created by Nikita Velichko on 06/02/23.
//

import Foundation

extension String {
    func deletingPrefix() -> String {
        let newString = self.components(separatedBy: "/")
        return newString[1]
    }
}
