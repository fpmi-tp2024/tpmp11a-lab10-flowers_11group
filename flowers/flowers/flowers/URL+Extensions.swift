import Foundation

extension URL {
    
    static func urlForWeatherFor(_ city: String) -> URL? {
        var real = String()
        
        // Обработка специальных случаев для названий городов с пробелами
        if (city == "San Francisco") {
            real = "San%20Francisco"
        } else if (city == "Rio de Janeiro") {
            real = "Rio%20de%20Janeiro"
        } else {
            real = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        }
        
        // Формирование URL для запроса к API
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(real)&appid=6b2d8f2c79f08a56ed4e110d0ae91e25") else {
            return nil
        }
        
        return url
    }
    
}
