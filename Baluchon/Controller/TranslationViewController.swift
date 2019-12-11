//
//  TranslationViewController.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 05/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftGoogleTranslate.shared.start(with: apiUrl["googleTranslate"]!)
    }
    
    @IBAction func translateButton(_ sender: UIButton) {
        SwiftGoogleTranslate.shared.translate("Hello!", "es", "en") { (text, error) in
          if let t = text {
            print(t)
          }
        }
    }
    
    
}
