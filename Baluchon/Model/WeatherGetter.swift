//
//  WeatherGetter.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 06/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

class WeatherGetter {
    
var weatherDict: NSDictionary!
  
  private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather?q="
  private let openWeatherMapAPIKey = apiUrl["weatherKey"]!

  
  func getWeather(city: String) {
    var dictonary:NSDictionary!
    if let url = URL(string: "\(openWeatherMapBaseURL)\(city)&appid=\(openWeatherMapAPIKey)") {
       URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    if let data = jsonString.data(using: String.Encoding.utf8) {
                        do {
                            dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                            DispatchQueue.main.async {
                                self.weatherDict = dictonary
                            }
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }
            }
        }.resume()
    }
  }
    
  
}
