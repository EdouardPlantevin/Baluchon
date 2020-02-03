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
    let weather = WeatherGetter()
    
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
        weather.getWeather(city: "Caen") { (success, weather) in
            if success, let weather = weather {
                self.setWeather(description: weather.description, temp: weather.temp, image: weather.image, city: weather.city, time: weather.time)
                self.hiddenWeatherFalse()
            }
        }
        self.textfieldNewCity.addTarget(self, action: #selector(addNewCity(_:)), for: UIControl.Event.editingDidEndOnExit)
    }
    
    // Func
    
    func setMoonToTimeImage() {
        timeImage.image = UIImage(systemName: "moon.fill")
    }
    
    func setSunToTimeImage() {
        timeImage.image = UIImage(systemName: "sun.max.fill")
    }
    
    
    func setWeather(description: String?, temp: Int, image: String, city: String?, time: String?) {
        let replaced = (city! as NSString).replacingOccurrences(of: "+", with: " ")
        self.currentCityLabel.text = replaced
        let degrees: Double = Double(temp) - 273.15
        self.degreesLabel.text = "\(degrees.rounded()) °C"
        self.detailWeatherLabel.text = description
        self.timeLabel.text = time
        currentWeatherImage.image = UIImage(named: WeatherData.getImage(image: image))
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
                    self.setWeather(description: weather.description, temp: weather.temp, image: weather.image, city: weather.city, time: weather.time)
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
