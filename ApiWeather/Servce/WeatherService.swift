//
//  WeatherService.swift
//  ApiWeather
//
//  Created by Alper Erden on 17.05.2023.
//

import Foundation
final class WeatherService {
    
    func apicall(completion: @escaping ([String: Any]?) -> Void) {
        let api = "48d3a2e584d8b83fe5150cef4120a1d0"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=41.00029294737165&lon=28.858640475678147&appid=\(api)"

        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Hata: \(error)")
                    completion(nil)
                    return
                }

                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        completion(jsonResponse)
                    } catch {
                        print("JSON dönüşüm hatası: \(error)")
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
            task.resume()
        } else {
            print("Geçersiz URL: \(urlString)")
            completion(nil)
        }
    }
}
