//
//  WeatherDetailViewControllerTests.swift
//  WeatherProjectTests
//
//  Created by Kanika Jain on 12/10/23.
//

import XCTest
@testable import WeatherProject

final class WeatherDetailViewControllerTests: XCTestCase {
    var weatherDetailVCTest :WeatherDetailViewController!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        weatherDetailVCTest = storyboard.instantiateViewController(identifier: "WeatherDetailViewController") as WeatherDetailViewController
        weatherDetailVCTest.model = WeatherModel(location: LocationData(name: "Delhi", region: "Asia", country: "India"), current: CurrentData(wind_kph: 11.0, temp_c: 11.0, condition: nil), forecast: nil)
        weatherDetailVCTest.loadView()
        weatherDetailVCTest.viewDidLoad()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        weatherDetailVCTest = nil
    }

    
    func testHasTableViewDataSource() {
        XCTAssertNotNil(weatherDetailVCTest.tableView.dataSource)
    }

    func testHasTableViewDelegate() {
        XCTAssertNotNil(weatherDetailVCTest.tableView.delegate)
    }
    

}
