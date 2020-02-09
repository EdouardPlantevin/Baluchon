//
//  WeatherGetterTestCase.swift
//  BaluchonTests
//
//  Created by Edouard PLANTEVIN on 03/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import XCTest
@testable import Baluchon

class WeatherGetterTestCase: XCTestCase {

    func testGivenWeatherGetter_WhenGiveTimeZone_ThenShouldReturnDateAndTime() {
        //Given
        let weather = WeatherService(session: URLSession(configuration: .default))
        
        //Create
        let date = weather.getDate(timezone: 3600.0)
        
        // Then
        XCTAssert(date.count == 11)
    }
    
}
