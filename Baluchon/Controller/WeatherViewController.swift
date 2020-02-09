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
    let weather = WeatherService(session: URLSession(configuration: .default))
    
    //Outlet
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var degressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeImage: UIImageView!
    @IBOutlet weak var detailWeatherLabel: UILabel!
    @IBOutlet weak var textfieldNewCity: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        weather.getWeather(city: "caen") { (success, weather) in
            if success, let weather = weather {
                self.setWeather(description: weather.weather.first!.weatherDescription, temp: Int(weather.main.temp), image: weather.weather.first!.icon, city: weather.name, time: self.weather.getDate(timezone: weather.timezone))
                self.hiddenWeatherFalse()
            }
        }
        self.textfieldNewCity.addTarget(self, action: #selector(addNewCity(_:)), for: UIControl.Event.editingDidEndOnExit)
    }
    
    // Func
    
    func setMoonToTimeImage() {
        timeImage.image = UIImage(named: "moon")
    }
    
    func setSunToTimeImage() {
        timeImage.image = UIImage(named: "sunWeather")
    }
    
    
    func setWeather(description: String?, temp: Int, image: String, city: String?, time: String?) {
        let replaced = (city! as NSString).replacingOccurrences(of: "+", with: " ")
        self.currentCityLabel.text = replaced
        let degrees: Double = Double(temp) - 273.15
        self.degreesLabel.text = "\(degrees.rounded()) °C"
        self.detailWeatherLabel.text = description
        self.timeLabel.text = time
        currentWeatherImage.image = UIImage(named: WeatherService.getImage(image: image))
        if image.contains("d") {
            setSunToTimeImage()
        } else {
            setMoonToTimeImage()
        }

    }
    
    // Button
    @IBAction func addNewCityButton() {
        textfieldNewCity.isHidden = !textfieldNewCity.isHidden
        textfieldNewCity.resignFirstResponder()
    }
    
    @IBAction func addNewCity(_ sender: Any) {
        if textfieldNewCity.text != nil && textfieldNewCity.text != "" {
            let replaced = (textfieldNewCity.text! as NSString).replacingOccurrences(of: " ", with: "+")
            weather.getWeather(city: replaced) { (success, weather) in
                if success, let weather = weather {
                    self.setWeather(description: weather.weather.first!.weatherDescription, temp: Int(weather.main.temp), image: weather.weather.first!.icon, city: weather.name, time: self.weather.getDate(timezone: weather.timezone))
                }
            }
        }
        textfieldNewCity.resignFirstResponder()
        textfieldNewCity.isHidden = true
    }
    
    func hiddenWeatherFalse() {
        textfieldNewCity.isHidden = false
        currentCityLabel.isHidden = false
        degreesLabel.isHidden = false
        currentWeatherImage.isHidden = false
        timeLabel.isHidden = false
        timeImage.isHidden = false
        detailWeatherLabel.isHidden = false
        textfieldNewCity.isHidden = false
        activityIndicator.stopAnimating()
    }
    
}
