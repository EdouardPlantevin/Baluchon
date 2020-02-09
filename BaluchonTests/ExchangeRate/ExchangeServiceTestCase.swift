//
//  ExchangeRateTestCase.swift
//  BaluchonTests
//
//  Created by Edouard PLANTEVIN on 07/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import XCTest
@testable import Baluchon

class ExchangeRateTestCase: XCTestCase {

    func testGetRateShouldPostFailedCallbackIfError() {
        //Given
        let rate = ExchangeService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        rate.getRate { (success, rate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIfNoData() {
        //Given
        let rate = ExchangeService(session: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        rate.getRate { (success, rate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIfIncorrectResponse() {
        //Given
        let rate = ExchangeService(session: URLSessionFake(data: FakeResponseData.ratesCorrectData, response: FakeResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        rate.getRate { (success, rate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIfIncorrectData() {
        //Given
        let rate = ExchangeService(session: URLSessionFake(data: FakeResponseData.rateIncorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        rate.getRate { (success, rate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostSuccessCallbackIfAllIsCorrect() {
        //Given
        let rate = ExchangeService(session: URLSessionFake(data: FakeResponseData.ratesCorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        rate.getRate { (success, rate) in
            //Then
            let currency = ["AED", "AFN"]
            let value = [4.027334, 84.213249]
            XCTAssertTrue(success)
            XCTAssertNotNil(rate)
            XCTAssertEqual(currency, rate?.myCurrency)
            XCTAssertEqual(value, rate?.myValues)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
