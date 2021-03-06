//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 05/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    var rate = ExchangeService(session: URLSession(configuration: .default))
    
    //Use for resultLabel
    var activeValue: Double = 0
    var activeCurrency: String = ""

    
    //Object
    @IBOutlet weak var textFieldRate: UITextField!
    @IBOutlet weak var pickerViewDevice: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerViewDevice.setValue(UIColor.white, forKeyPath: "textColor")
        self.rate.getRate { (success, exchange) in
            if success, let exchange = exchange {
                self.update(exchange: exchange)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func update(exchange: ExchangeData) {
        DispatchQueue.main.async {
            self.rate.myCurrency = exchange.myCurrency
            self.rate.myValues = exchange.myValues
            self.pickerViewDevice.reloadAllComponents()
        }
    }
    
    
    // Button
    @IBAction func convertButton(_ sender: UIButton) {
        textFieldRate.resignFirstResponder()
        if (textFieldRate.text != nil && textFieldRate.text != "") {
            if let number = textFieldRate.text, number.isInt {
                if let numberDouble = Double(number) {
                    resultLabel.text = ExchangeData.convertToResult(activeValue: activeValue, money: numberDouble, activeCurrency: activeCurrency)
                }
            } else {
                if let wrongResult = textFieldRate.text {
                    presentAlert(view: self, message: "Vous vouliez vraiment convertir \(wrongResult) ?")
                }
            }
        } else {
            presentAlert(view: self, message: "Vous n'avez entré aucun chiffre")
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textFieldRate.resignFirstResponder()
    }

}


 //PickerView
extension ExchangeRateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rate.myCurrency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rate.myCurrency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeValue = rate.myValues[row]
        activeCurrency = rate.myCurrency[row]
    }
}
