//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 05/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let date = Date()
    let format = DateFormatter()
    
    //Outlet
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var degressLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var timeImage: UIImageView!
    @IBOutlet weak var detailWeatherLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather(city: "Caen")
    }
    
    // Func
    
    func setMoonToTimeImage() {
        timeImage.image = UIImage(systemName: "moon.fill")
    }
    
    func setSunToTimeImage() {
        timeImage.image = UIImage(systemName: "sun.max.fill")
    }

    
    func getWeather(city: String) {
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather?q="
    let openWeatherMapAPIKey = apiUrl["weatherKey"]!
        guard let url = URL(string: "\(openWeatherMapBaseURL)\(city)&appid=\(openWeatherMapAPIKey)&lang=fr") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {return}
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any] else {return}
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String)?.capitalizingFirstLetter()
                    DispatchQueue.main.async {
                        self.setWeather(weather: weatherDetails.first?["main"] as? String, description: description, temp: temp, city: city)
                    }
                } catch {
                    print("No data")
                }
            }
        }
        task.resume()
    }
    
    func setWeather(weather: String?, description: String?, temp: Int, city: String?) {
        self.currentCityLabel.text = city
        let degrees: Double = Double(temp) - 273.15
        self.degreesLabel.text = "\(degrees.rounded()) °C"
        self.weatherLabel.text = weather
        self.detailWeatherLabel.text = description
        setDate()
    }
    
    func setDate() {
        format.dateFormat = "dd/MM HH:mm"
        let formattedDate = format.string(from: date)
        weatherLabel.text = String(formattedDate)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
