//
//  WeatherGetter.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 06/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

class WeatherGetter {
    
    func getWeather(city: String, callback: @escaping (Bool, WeatherData?) -> Void) {
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather?q="
    let openWeatherMapAPIKey = apiUrl["weatherKey"]!
        guard let url = URL(string: "\(openWeatherMapBaseURL)\(city)&appid=\(openWeatherMapAPIKey)&lang=fr") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {return}
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any], let weatherTime = json["timezone"] as? Double else {return}
                    let image = (weatherDetails.first?["icon"] as? String) ?? ""
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String)?.capitalizingFirstLetter()
                    DispatchQueue.main.async {
                        let time = self.getDate(timezone: weatherTime)
                        let weatherData = WeatherData(description: description!, temp: temp, city: city, image: image, time: time)
                        callback(true, weatherData)
                    }
                } catch {
                    print("no data")
                }
            }
        }
        task.resume()
    }
    
    func getDate(timezone: Double) -> String {
        var date = Date()
        var interval = TimeInterval()
        interval = timezone
        date.addTimeInterval(interval)
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "dd-MM HH:mm"

        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let dateD = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd/MM HH:mm"
        // again convert your date to string
        let myStringafd = formatter.string(from: dateD!)
        return myStringafd
    }
  
}
