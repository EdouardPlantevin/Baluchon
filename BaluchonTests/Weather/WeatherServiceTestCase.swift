//
//  WeatherServiceTestCase.swift
//  BaluchonTests
//
//  Created by Edouard PLANTEVIN on 09/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import XCTest
@testable import Baluchon

class WeatherServiceTestCase: XCTestCase {

    func testGetWeatherShouldPostFailedCallbackIfError() {
        //Given
        let weather = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather(city: "caen") { (success, weather) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        //Given
        let weather = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather(city: "caen") { (success, weather) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        //Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather(city: "caen") { (success, weather) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        //Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.rateIncorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather(city: "caen") { (success, weather) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfAllIsCorrect() {
        //Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather(city: "caen") { (success, weather) in
            //Then
            let city = "Caen"
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            XCTAssertEqual(city, weather?.name)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
