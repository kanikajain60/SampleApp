//
//  VenuesViewControllerTests.swift
//  PublicVenueTests
//
//  Created by Amit Kumar on 14/09/20.
//  Copyright © 2020 Amit Kumar. All rights reserved.
//

import XCTest
@testable import WeatherProject

class ViewControllerTests: XCTestCase {

    var viewControllerUnderTest: ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
    
        viewControllerUnderTest.loadView()
        viewControllerUnderTest.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewControllerUnderTest = nil
        super.tearDown()
    }

    func testViewDidLoad (){
        XCTAssertNoThrow(viewControllerUnderTest.viewDidLoad())
    }
}
