//
//  TranslationManager.swift .swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 12/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

class TranslationManager: NSObject {
 
    static let shared = TranslationManager()
 
    private let apiKey = "\(apiUrl["googleTranslate"]!)"
 
 
    override init() {
        super.init()
    }
    
    private func makeRequest(usingTranslationAPI api: TranslationAPI, urlParams: [String: String], completion: @escaping (_ results: [String: Any]?) -> Void) {
     if var components = URLComponents(string: api.getURL()) {
      
     }
    }
}
