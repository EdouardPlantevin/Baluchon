//
//  Translate.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 07/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct FinalTranslate: Codable {
    let data: DataClassTranlate
}

// MARK: - DataClass
struct DataClassTranlate: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText: String
}
