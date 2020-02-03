//
//  LanguageViewController.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 03/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    
    ///Outlet
    @IBOutlet weak var pickerViewLanguage: UIPickerView!
    
    
    var currentLanguage = "fr"

    override func viewDidLoad() {
        super.viewDidLoad()
         self.pickerViewLanguage.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    ///Button
    @IBAction func validateButton(_ sender: UIButton) {
        UserDefaults.standard.set(currentLanguage, forKey: "currentLanguage")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension LanguageViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    //PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LanguageData.shared.languagesName.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return LanguageData.shared.languagesName[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentLanguage = LanguageData.shared.languagesInitial[row]
    }
    
}
