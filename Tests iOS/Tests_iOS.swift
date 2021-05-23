//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by DerouicheElyes on 22/5/2021.
//

import XCTest
@testable import SuperRun

class Tests_iOS: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDetailsViewModel() {
        
        let city = City(city: "City name", isOnline: true, distance: 123, locations: [])
        
        let viewModel = SheetViewModel(location: city)
        
        
        XCTAssertFalse(viewModel.cityName.isEmpty, "City name should not be empty")
        XCTAssertFalse(viewModel.distance.starts(with: "0"), "Distance should not contains Zero")
        
        if viewModel.isCity {
            XCTAssertTrue(viewModel.locations == 0, "Should not be empty")
        }
        
        
        XCTAssertNil(URL(string: AppConfig.EndPoints.locations.buildPath()), "Url should be well formatted")
        
    }
    
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
