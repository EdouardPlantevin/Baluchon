//
//  LanguageData.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 03/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

class LanguageData {
    static let shared = LanguageData()
    private init() {}
    
    private(set) var languagesName: [String] = []
    private(set) var languagesInitial: [String] = []
    
    func add(languages: [SwiftGoogleTranslate.Language]) {
        for language in languages {
            languagesName.append(language.name)
            languagesInitial.append(language.language)
        }
    }
}
