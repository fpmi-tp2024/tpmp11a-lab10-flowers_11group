//
//  WeatherService.swift
//  flowers
//
//  Created by Irina on 29.05.2024.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class WeatherService {
    public static var temper = 0.0
    
    func getWeather(city: String,completion: @escaping (Result<Weather?, NetworkError>) -> Void) {
        
        guard let url = URL.urlForWeatherFor(city) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            if let weatherResponse = weatherResponse {
                WeatherService.temper = weatherResponse.main.temp 
                completion(.success(weatherResponse.main))
            } else {
                completion(.failure(.decodingError))
            }
            

            
        }.resume()
        
    }
    
}
