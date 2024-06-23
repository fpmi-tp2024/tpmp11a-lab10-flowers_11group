//
//  WeatherResponse.swift
//  flowers
//
//  Created by Irina on 29.05.2024.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
