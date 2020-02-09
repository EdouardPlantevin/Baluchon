//
//  Language.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 07/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

import Foundation

// MARK: - FinalLanguage
struct FinalLanguage: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let languages: [LanguageElement]
}

// MARK: - LanguageElement
struct LanguageElement: Codable {
    let language, name: String
}
