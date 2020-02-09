//
//  TranslateService.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 07/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

class TranslateService {
    
    static let shared = TranslateService()
    private init() {}
    
    private(set) var languagesName: [String] = []
    private(set) var languagesInitial: [String] = []
    
    func add(languages: [LanguageElement]) {
        for language in languages {
            languagesName.append(language.name)
            languagesInitial.append(language.language)
        }
    }
    
    var allLanguages: [LanguageElement] = []
    
    private var task: URLSessionDataTask?
    private var sessionLanguage = URLSession(configuration: .default)
    private var sessionTranslate = URLSession(configuration: .default)
    
    init(sessionLanguage: URLSession, sessionTranslate: URLSession) {
        self.sessionLanguage = sessionLanguage
        self.sessionTranslate = sessionTranslate
    }
    
    private let supportingLanguage = URL(string: "https://translation.googleapis.com/language/translate/v2/languages")!
    private let traductionLanguage = URL(string: "https://www.googleapis.com/language/translate/v2")!
    private let keyGoogle = ApiKey.googleKey
    
    func getLanguage(callBack: @escaping (Bool,[LanguageElement]?) -> Void) {
        
        var request = URLRequest(url: supportingLanguage)
        request.httpMethod = "POST"
        
        let body = "model=nmt&target=fr&key=\(keyGoogle)"
        request.httpBody = body.data(using: .utf8)
        
        task?.cancel()
        
        task = sessionLanguage.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return
                }
                // JSON decodable
                guard let responseJSON = try? JSONDecoder().decode(FinalLanguage.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                for language in responseJSON.data.languages {
                    self.allLanguages.append(language)
                }
                callBack(true, self.allLanguages)
            }
        }
        task?.resume()
    }
    
    func getTranslate(q: String, source: String, target: String ,callBack: @escaping (Bool,String?) -> Void) {
        
        var request = URLRequest(url: traductionLanguage)
        request.httpMethod = "POST"
        
        let body = "q=\(q)&source=\(source)&target=\(target)&key=\(keyGoogle)"
        request.httpBody = body.data(using: .utf8)
        
        task?.cancel()
        
        task = sessionTranslate.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return
                }
                // JSON decodable
                guard let responseJSON = try? JSONDecoder().decode(FinalTranslate.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                let responseString = responseJSON.data.translations.first!.translatedText
                callBack(true, responseString)
            }
        }
        task?.resume()
    }
    
    
    
    
}
