//
//  ExchangeDataTestCase.swift
//  BaluchonTests
//
//  Created by Edouard PLANTEVIN on 04/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import XCTest
@testable import Baluchon

class ExchangeDataTestCase: XCTestCase {

    func testGivenDouble_WhenCallConvertDouble_ThenShouldReturnDoubleWith3decimalAndString() {
        let result = ExchangeData.convertDouble(number: 1.111111)
        
        XCTAssert(result == "1.111")
    }
    
    func testGivenCalcul_WhenCallConvertToResult_ThenShouldReturnString() {
        let result = ExchangeData.convertToResult(activeValue: 2.0, money: 10.0, activeCurrency: "EUR")
        
        XCTAssert(result == "20.0 EUR")
    }

}
