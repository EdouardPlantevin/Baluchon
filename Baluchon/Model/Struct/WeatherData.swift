//
//  WeatherData.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 17/01/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

struct WeatherData {
    var description: String
    var temp: Int
    var city: String
    var image: String
    var time: String
    
    static func getImage(image: String) -> String {
        print(image)
        switch image {
        case "01d":
            return "01"
        case "01n":
            return "01"
        case "02d":
            return "02"
        case "02n":
            return "02"
        case "03d":
            return "03"
        case "03n":
            return "03"
        case "04d":
            return "04"
        case "04n":
            return "04"
        case "09d":
            return "09"
        case "09n":
            return "09"
        case "10d":
            return "10"
        case "10n":
            return "10"
        case "11d":
            return "11"
        case "11n":
            return "11"
        case "13d":
            return "13"
        case "13n":
            return "13"
        case "50d":
            return "50"
        case "50n":
            return "50"
        default:
            return "01"
        }
    }
}

//01d.png
