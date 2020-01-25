//
//  ExchangeRate.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 05/12/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

class ExchangeRate {
    var myCurrency:[String] = []
    var myValues:[Double] = []

    func getAllDevice(callback: @escaping (Bool, ExchangeData?) -> Void) {
        let url = URL(string: apiUrl["rateUrl"]!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error")
            } else {
                if let content = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary {
                            for (key, value) in rates {
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                        }
                        let exchangeData = ExchangeData(myCurrency: self.myCurrency, myValues: self.myValues)
                        callback(true, exchangeData)
                    } catch {
                       print("Error")
                    }
                }
            }
        }
        task.resume()
    }
}


