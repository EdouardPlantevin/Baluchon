//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 05/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let rate = ExchangeRate()
    
    var activeValue: Double = 0
    var activeCurrency: String = ""
    
    var test:Int = 0
    
    //Object
    @IBOutlet weak var textFieldRate: UITextField!
    @IBOutlet weak var pickerViewDevice: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    //PickerView
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rate.getAllDevice()
        pickerViewDevice.reloadAllComponents()
    }
    
    
    // Button
    @IBAction func convertButton(_ sender: UIButton) {
        resultLabel.text = String(Int(Double(textFieldRate.text!)! * activeValue))
        resultLabel.text = resultLabel.text! + " " + activeCurrency
    }
    
}
