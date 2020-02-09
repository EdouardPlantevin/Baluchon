//
//  WeatherGetter.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 06/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

class WeatherService {

    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    private let weatherAPI = ApiKey.weatherKey
    
    private let weatherBase = URL(string: "http://api.openweathermap.org/data/2.5/weather")!
    
    func getWeather(city: String, callBack: @escaping (Bool,Weather?) -> Void) {
        
        let weatherURL = URL(string: "\(weatherBase)?q=\(city)&appid=\(weatherAPI)&lang=fr")!
            
        task?.cancel()

        task = session.dataTask(with: weatherURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return
                }
                // JSON decodable
                guard let weather = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                callBack(true, weather)
            }
        }
        task?.resume()
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
        if let dateD = dateD {
            let myStringafd = formatter.string(from: dateD)
            return myStringafd
        }
        return "Erreur Date"
    }
    
    static func getImage(image: String) -> String {
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
