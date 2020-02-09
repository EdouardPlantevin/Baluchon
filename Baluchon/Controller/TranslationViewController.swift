//
//  TranslationViewController.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 05/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    
    var activeLanguage: String = "en"
    var googleTest = TranslateService(sessionLanguage: URLSession(configuration: .default), sessionTranslate: URLSession(configuration: .default))
    
    /// Outlet
    @IBOutlet weak var textfieldTranslate: UITextField!
    @IBOutlet weak var labelTranslate: UITextView!
    @IBOutlet weak var pickerViewLanguage: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerViewLanguage.setValue(UIColor.white, forKeyPath: "textColor")
        googleTest.getLanguage { (success, languages)  in
            TranslateService.shared.add(languages: languages!)
            DispatchQueue.main.async {
                self.pickerViewLanguage.reloadAllComponents()
                self.activityIndicator.stopAnimating()
                self.pickerViewLanguage.isHidden = false
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textfieldTranslate.resignFirstResponder()
    }
    
    @IBAction func translateBtn(_ sender: Any) {
        let currentLanguage = UserDefaults.standard.object(forKey: "currentLanguage") ?? "fr"
        if let text = textfieldTranslate.text {
            googleTest.getTranslate(q: "\(text)", source: "\(currentLanguage)", target: "\(activeLanguage)") { (success, result) in
                if let result = result, result != "" {
                    self.labelTranslate.text = result
                } else {
                    presentAlert(view: self, message: "Traduction impossible\nMême langue ?")
                }
            }
        }

    }
    
    @IBAction func dismissKeybordFormTextfield(_ sender: UITextField) {
        textfieldTranslate.resignFirstResponder()
    }
    
    
}

 //PickerView
extension TranslationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TranslateService.shared.languagesInitial.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TranslateService.shared.languagesName[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeLanguage = TranslateService.shared.languagesInitial[row]
    }
}
