//
//  TranslationViewController.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 05/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var activeLanguage: String = "fr"
    
    /// Outlet
    @IBOutlet weak var textfieldTranslate: UITextField!
    @IBOutlet weak var labelTranslate: UITextView!
    @IBOutlet weak var pickerViewLanguage: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
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
        activeLanguage = LanguageData.shared.languagesInitial[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerViewLanguage.setValue(UIColor.white, forKeyPath: "textColor")
        SwiftGoogleTranslate.shared.start(with: "\(apiUrl["googleTranslate"]!)")
        SwiftGoogleTranslate.shared.languages { (languages, error) in
          if let languages = languages {
            LanguageData.shared.add(languages: languages)
            DispatchQueue.main.async {
                self.pickerViewLanguage.reloadAllComponents()
                self.activityIndicator.stopAnimating()
                self.pickerViewLanguage.isHidden = false
            }
          }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textfieldTranslate.resignFirstResponder()
    }
    
    @IBAction func translateBtn(_ sender: Any) {
        let currentLanguage = UserDefaults.standard.object(forKey: "currentLanguage")!
        if textfieldTranslate.text != nil && textfieldTranslate.text != "" {
            SwiftGoogleTranslate.shared.translate("\(textfieldTranslate.text!)","\(activeLanguage)", "\(currentLanguage)") { (text, error) in
                if let t = text {
                    DispatchQueue.main.async {
                        self.labelTranslate.text = "\(t)"
                    }
                } else {
                    DispatchQueue.main.async {
                        presentAlert(view: self, message: "Traduction impossible\nMauvaise orthographe ? \nMême langue ?")
                    }
                }
            }
        } else {
            presentAlert(view: self, message: "Aucun mot à traduire")
        }
    }
    
    @IBAction func dismissKeybordFormTextfield(_ sender: UITextField) {
        textfieldTranslate.resignFirstResponder()
    }
    
    
}
