//
//  WeatherDateTestCase.swift
//  BaluchonTests
//
//  Created by Edouard PLANTEVIN on 03/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import XCTest
@testable import Baluchon

class WeatherDateTestCase: XCTestCase {

    func testGivenNoImage_WhenGive01d_ThenShouldReturn01() {
        let image = WeatherData.getImage(image: "01d")
        
        XCTAssert(image == "01")
    }
    
    func testGivenNoImage_WhenGive01n_ThenShouldReturn01() {
        let image = WeatherData.getImage(image: "01n")
        
        XCTAssert(image == "01")
    }
    
    func testGivenNoImage_WhenGive02d_ThenShouldReturn02() {
        let image = WeatherData.getImage(image: "02d")
        
        XCTAssert(image == "02")
    }
    
    func testGivenNoImage_WhenGive02n_ThenShouldReturn02() {
        let image = WeatherData.getImage(image: "02n")
        
        XCTAssert(image == "02")
    }
    
    func testGivenNoImage_WhenGive03d_ThenShouldReturn03() {
        let image = WeatherData.getImage(image: "03d")
        
        XCTAssert(image == "03")
    }
    
    func testGivenNoImage_WhenGive03n_ThenShouldReturn03() {
        let image = WeatherData.getImage(image: "03n")
        
        XCTAssert(image == "03")
    }
    
    func testGivenNoImage_WhenGive04d_ThenShouldReturn04() {
        let image = WeatherData.getImage(image: "04d")
        
        XCTAssert(image == "04")
    }
    
    func testGivenNoImage_WhenGive04n_ThenShouldReturn04() {
        let image = WeatherData.getImage(image: "04n")
        
        XCTAssert(image == "04")
    }
    
    func testGivenNoImage_WhenGive09d_ThenShouldReturn09() {
        let image = WeatherData.getImage(image: "09d")
        
        XCTAssert(image == "09")
    }
    
    func testGivenNoImage_WhenGive09n_ThenShouldReturn09() {
        let image = WeatherData.getImage(image: "09n")
        
        XCTAssert(image == "09")
    }
    
    func testGivenNoImage_WhenGive10d_ThenShouldReturn10() {
        let image = WeatherData.getImage(image: "10d")
        
        XCTAssert(image == "10")
    }
    
    func testGivenNoImage_WhenGive10n_ThenShouldReturn10() {
        let image = WeatherData.getImage(image: "10n")
        
        XCTAssert(image == "10")
    }
    
    func testGivenNoImage_WhenGive11d_ThenShouldReturn11() {
        let image = WeatherData.getImage(image: "11d")
        
        XCTAssert(image == "11")
    }
    
    func testGivenNoImage_WhenGive11n_ThenShouldReturn11() {
        let image = WeatherData.getImage(image: "11n")
        
        XCTAssert(image == "11")
    }
    
    func testGivenNoImage_WhenGive13d_ThenShouldReturn13() {
        let image = WeatherData.getImage(image: "13d")
        
        XCTAssert(image == "13")
    }
    
    func testGivenNoImage_WhenGive13n_ThenShouldReturn11() {
        let image = WeatherData.getImage(image: "13n")
        
        XCTAssert(image == "13")
    }
    
    func testGivenNoImage_WhenGive50d_ThenShouldReturn50() {
        let image = WeatherData.getImage(image: "50d")
        
        XCTAssert(image == "50")
    }
    
    func testGivenNoImage_WhenGive50n_ThenShouldReturn50() {
        let image = WeatherData.getImage(image: "50n")
        
        XCTAssert(image == "50")
    }
    
    func testGivenNoImage_WhenGive1000_ThenShouldReturn01() {
        let image = WeatherData.getImage(image: "1000")
        
        XCTAssert(image == "01")
    }
    
}
