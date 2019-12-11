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
    var temp: Int = 0 {
        didSet {
            print("bonjour")
        }
    }
    
    var description: String? = ""
  
  private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather?q="
  private let openWeatherMapAPIKey = apiUrl["weatherKey"]!


    
  
}
