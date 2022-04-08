//
//  Mobile_ObservatoryTests.swift
//  Mobile-ObservatoryTests
//
//  Created by Рустем on 08.04.2022.
//

import XCTest
@testable import Mobile_Observatory


class Mobile_ObservatoryTests: XCTestCase {
    var networkService: NetworkService!
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        networkService = NetworkService.shared
    }

    override func tearDownWithError() throws {
        networkService = nil
        try super.tearDownWithError()
    }

       
    func testIfWeatherDataParsesCorrectly() {
        let expectation = expectation(description: "max_temp = -23")
        networkService.getWeatherData(sol: "500") { result in
            switch result {
            case .success(let weatherInfo):
                if (weatherInfo.maxTemp == -23) {
                    expectation.fulfill()
                }
            case.failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
    

}
