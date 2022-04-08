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
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testIfModuleBuilderCreatesAllComponents() {
        
        let viewController = FeedModuleBuilder().build()
        XCTAssertNotNil(viewController)
    }
    
    
    
    func testIfNetworkErrorIsCaught() {
        let expectation = expectation(description: "Should return .noDataAvailable error")
        networkService.getImageByUrl(url: "blablabla") { result in
            switch result {
            case .success(_):
                XCTFail()
            case.failure(let error):
                if (error == .noDataAvailable) {
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
    
    func testIfPictureUrlConvertsToUIImage() {
        let expectation = expectation(description: "Function returns not nil UIImage")
        networkService.getPicOfDay(date: Date.init(year: 2020, month: 05, day: 01, hour: 0, minute: 0)) { result in
            switch result {
            case .success(let picOfDay):
                self.networkService.getImageByUrl(url: picOfDay.imageUrl.description) { result in
                    switch result {
                    case .success(let image):
                        XCTAssertNotNil(image)
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                    }
                
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
    
    

}
