//
//  ExchangeData.swift
//  Baluchon
//
//  Created by Edouard PLANTEVIN on 17/01/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import Foundation

struct ExchangeData: Decodable {
    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    static func convertDouble(number: Double) -> String {
        var finalNumber = number
        finalNumber = round(1000*number)/1000
        return String(finalNumber)
    }
    
    static func convertToResult(activeValue: Double, money: Double, activeCurrency: String) -> String {
        let result = (Double(money)) * activeValue
        let finalResult = convertDouble(number: result)
        return "\(finalResult) \(activeCurrency)"
    }
}
