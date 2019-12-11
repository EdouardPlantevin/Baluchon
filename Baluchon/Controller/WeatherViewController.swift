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
    
    override func viewWillAppear(_ animated: Bool) {
        textfieldNewCity.isHidden = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather(city: "Caen")
        self.textfieldNewCity.addTarget(self, action: #selector(addNewCity(_:)), for: UIControl.Event.editingDidEndOnExit)
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
                    let image = (weatherDetails.first?["icon"] as? String) ?? ""
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String)?.capitalizingFirstLetter()
                    DispatchQueue.main.async {
                        self.setWeather(description: description, temp: temp, image: image, city: city)
                    }
                } catch {
                    print("No data")
                }
            }
        }
        task.resume()
    }

    
    func setWeather(description: String?, temp: Int, image: String, city: String?) {
        let replaced = (city! as NSString).replacingOccurrences(of: "+", with: " ")
        self.currentCityLabel.text = replaced
        let degrees: Double = Double(temp) - 273.15
        self.degreesLabel.text = "\(degrees.rounded()) °C"
        self.detailWeatherLabel.text = description
        let url = URL(string: "http://openweathermap.org/img/wn/\(image)@2x.png")!
        if image.contains("d") {
            setSunToTimeImage()
        } else {
            setMoonToTimeImage()
        }
        downloadImage(from: url)
        setDate()
    }
    
    func setDate() {
        format.dateFormat = "dd/MM HH:mm"
        let formattedDate = format.string(from: date)
        timeLabel.text = String(formattedDate)
    }
    
    
    //Image
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.currentWeatherImage.image = UIImage(data: data)
            }
        }
    }
    
    // Button
    @IBAction func addNewCityButton() {
        textfieldNewCity.isHidden = false
    }
    
    @IBAction func addNewCity(_ sender: Any) {
        if textfieldNewCity.text != nil && textfieldNewCity.text != "" {
            let replaced = (textfieldNewCity.text! as NSString).replacingOccurrences(of: " ", with: "+")
            getWeather(city: replaced)
        }
        textfieldNewCity.resignFirstResponder()
        textfieldNewCity.isHidden = true
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
