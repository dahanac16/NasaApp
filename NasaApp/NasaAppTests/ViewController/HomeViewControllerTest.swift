//
//  HomeViewControllerTest.swift
//  NasaAppTests
//
//  Created by Michel Arboleda on 28/01/25.
//

import XCTest
@testable import NasaApp

class HomeViewControllerTest: XCTestCase {
    
    var sut: HomeViewController?
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "HomeView") as? HomeViewController else {
            XCTFail("Could not instantiate viewController as HomeViewController")
            return
        }
        sut = viewController
        sut?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testNotNillSut() {
        XCTAssertNotNil(sut)
    }
    
    func testinitCollectionViewDataNotNil() {
        sut?.initCollectionView(data: TestSub.getDataNasa())
        XCTAssertNotNil(sut?.dataResult)
    }
    
    func testinitCollectionViewDataNil() {
        sut?.initCollectionView(data: TestSub.getDataNasaNil())
        XCTAssertNil(sut?.dataResult)
    }
    
    func testViewDidLoad() {
        sut?.viewDidLoad()
    }
}
