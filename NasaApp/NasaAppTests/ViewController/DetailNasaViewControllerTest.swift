//
//  DetailNasaViewControllerTest.swift
//  NasaAppTests
//
//  Created by Michel Arboleda on 28/01/25.
//

import XCTest
@testable import NasaApp

class DetailNasaViewControllerTest: XCTestCase {

    var sut: DetailNasaViewController?
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "DetailView") as? DetailNasaViewController else {
            XCTFail("Could not instantiate viewController as DetailNasaViewController")
            return
        }
        sut = viewController
        sut?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testSetTextNotNull() {
        let mData = TestSub.getDataNasa().collection?.items?.first?.data?.first
        sut?.titleNasa.text = mData?.title
        sut?.descriptionNasa.text = mData?.description
        XCTAssertNotNil(sut?.titleNasa.text)
        XCTAssertNotNil(sut?.descriptionNasa.text)
    }
    
    func testSetTextNull() {
        let mData = TestSub.getDataNasaNil()?.collection?.items?.first?.data?.first
        sut?.titleNasa.text = mData?.title
        sut?.descriptionNasa.text = mData?.description
        XCTAssertNil(sut?.titleNasa.text)
        XCTAssertEqual("", sut?.descriptionNasa.text)
    }
    
    func testViewDidLoad() {
        sut?.viewDidLoad()
    }
    
    func testNotNillSut() {
        XCTAssertNotNil(sut)
    }
    
}
