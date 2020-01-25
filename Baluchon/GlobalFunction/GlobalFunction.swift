//
//  GlobalFunction.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 16/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

// Show Alert
func presentAlert(view: UIViewController, message: String) {
    let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertVC.addAction(action)
    view.present(alertVC, animated: true, completion: nil)
}
