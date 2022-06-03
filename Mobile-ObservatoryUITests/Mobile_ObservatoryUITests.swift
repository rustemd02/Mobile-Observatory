//
//  Mobile_ObservatoryUITests.swift
//  Mobile-ObservatoryUITests
//
//  Created by andrewoch on 03.06.2022.
//

import XCTest
@testable import Mobile_Observatory

class Mobile_ObservatoryUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Spaceflight Now").staticTexts[" Нравится"]/*[[".cells.containing(.staticText, identifier:\"Russia’s Progress MS-20 cargo freighter is set for launch Friday on a fast-track, three-and-a-half hour rendezvous with the International Space Station to deliver around three tons of fuel, food, and supplies for the lab’s seven-person crew. Liftoff from Kazakhstan aboard a Soyuz rocket is set for 5:32 a.m. EDT (0932 GMT), followed by docking at 9:02 a.m. EDT (1302 GMT).\")",".buttons[\" Нравится\"].staticTexts[\" Нравится\"]",".staticTexts[\" Нравится\"]",".cells.containing(.staticText, identifier:\"Russian Soyuz rocket poised for launch with space station cargo freighter\")",".cells.containing(.staticText, identifier:\"Spaceflight Now\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
}
