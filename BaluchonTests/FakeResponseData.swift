//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Edouard PLANTEVIN on 07/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassroom.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassroom.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class GetError: Error {}
    static let error = GetError()
    
    static var ratesCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Rates", withExtension: "json") else {
            fatalError("Rates.json is not found.")
        }
        return try? Data(contentsOf: url)
    }
    
    static var languageCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Languages", withExtension: "json") else {
            fatalError("Languages.json is not found.")
        }
        return try? Data(contentsOf: url)
    }
    
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Translate", withExtension: "json") else {
            fatalError("Translate.json is not found.")
        }
        return try? Data(contentsOf: url)
    }
    
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Weather", withExtension: "json") else {
            fatalError("Weather.json is not found.")
        }
        return try? Data(contentsOf: url)
    }
    
    static let rateIncorrectData = "erreur".data(using: .utf8)!
}
