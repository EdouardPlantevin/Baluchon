//
//  ExchangeRate.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 05/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

class ExchangeService {
    
    var myCurrency: [String] = []
    var myValues: [Double] = []

    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    private let rateUrl = "http://data.fixer.io/api/latest?access_key="
    private let keyExchange = ApiKey.rateKey
    
    func getRate(callBack: @escaping (Bool,ExchangeData?) -> Void) {
        guard let url = URL(string: rateUrl + keyExchange) else { return }
        
        task?.cancel()
        
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode ==  200 else {
                    callBack(false, nil)
                    return
                }
                
                // JSON decodable
                guard let responseJSON = try? JSONDecoder().decode(Rates.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                let rates = responseJSON.rates
                let ratesSort = rates.sorted(by: <)
                for (key, value) in ratesSort {
                    self.myCurrency.append(key)
                    self.myValues.append(value)
                }
                let exchangeData = ExchangeData(myCurrency: self.myCurrency, myValues: self.myValues)
                callBack(true, exchangeData)
            }
        }
        task?.resume()
    }

}
