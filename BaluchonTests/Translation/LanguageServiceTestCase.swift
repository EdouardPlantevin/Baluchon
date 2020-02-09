//
//  LanguageServiceTestCase.swift
//  BaluchonTests
//
//  Created by Edouard PLANTEVIN on 07/02/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import XCTest
@testable import Baluchon

class LanguageServiceTestCase: XCTestCase {

    func testGetLanguageShouldPostFailedCallbackIfError() {
        //Given
        let translate = TranslateService(sessionLanguage: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error), sessionTranslate: URLSessionFake(data: nil, response: nil, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getLanguage { (success, rate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguageShouldPostFailedCallbackIfNoData() {
        //Given
        let translate = TranslateService(sessionLanguage: URLSessionFake(data: nil, response: nil, error: nil), sessionTranslate: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getLanguage { (success, rate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguageShouldPostFailedCallbackIfIncorrectResponse() {
        //Given
        let translate = TranslateService(sessionLanguage: URLSessionFake(data: FakeResponseData.languageCorrectData, response: FakeResponseData.responseKO, error: nil), sessionTranslate: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getLanguage { (success, rate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguageShouldPostFailedCallbackIfIncorrectData() {
        //Given
        let translate = TranslateService(sessionLanguage: URLSessionFake(data: FakeResponseData.rateIncorrectData, response: FakeResponseData.responseOK, error: nil), sessionTranslate: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getLanguage { (success, rate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
 
    
    func testGetLanguageShouldPostSuccessCallbackIfAllIsCorrect() {
        //Given
        let translate = TranslateService(sessionLanguage: URLSessionFake(data: FakeResponseData.languageCorrectData, response: FakeResponseData.responseOK, error: nil), sessionTranslate: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getLanguage { (success, languages) in
            //Then
            let lang = "af"
            XCTAssertTrue(success)
            XCTAssertNotNil(languages)
            XCTAssertEqual(lang, languages?.first?.language)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Tranlate
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        //Given
        let translate = TranslateService(sessionLanguage: URLSessionFake(data: nil, response: nil, error: nil), sessionTranslate: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(q: "fromage", source: "fr", target: "en") { (success, result) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        //Given
        let translate = TranslateService(sessionLanguage: URLSessionFake(data: nil, response: nil, error: nil), sessionTranslate: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(q: "fromage", source: "fr", target: "en") { (success, rate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoResponse() {
        //Given
        let translate = TranslateService(sessionLanguage: URLSessionFake(data: nil, response: nil, error: nil), sessionTranslate: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(q: "fromage", source: "fr", target: "en") { (success, result) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        //Given
        let translate = TranslateService(sessionLanguage: URLSessionFake(data: nil, response: nil, error: nil), sessionTranslate: URLSessionFake(data: FakeResponseData.rateIncorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(q: "fromage", source: "fr", target: "en") { (success, rate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    
    func testGetTranslateShouldPostSuccessCallbackIfAllIsCorrect() {
        //Given
        let translate = TranslateService(sessionLanguage: URLSessionFake(data: nil, response: nil, error: nil), sessionTranslate: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(q: "fromage", source: "fr", target: "en") { (success, result) in
            //Then
            let finalResult = "cheese"
            XCTAssertTrue(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(finalResult, result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    //share
    func testGetNoDataSouldAddLanguageWhenAddData() {
        TranslateService.shared.add(languages: [Baluchon.LanguageElement(language: "af", name: "Afrikaans")])
        let initial = TranslateService.shared.languagesInitial
        let language = TranslateService.shared.languagesName
        XCTAssertEqual(initial, ["af"])
        XCTAssertEqual(language, ["Afrikaans"])
        
    }

}
