//
//  HeroeDetailTests.swift
//  HeroesMVVMTests
//
//  Created by Daniel Rincon Vega on 21/1/22.
//

import XCTest
@testable import HeroesMVVM

class HeroeDetailTests: XCTestCase {

    let sut : HeroeDetailVM = HeroeDetailVM(apiSession: APISessionMock(), dataManager: DataManagerMock())
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNoImgURL() throws {
        sut.getHeroe(heroe: HeroeModel.previewHeroe)
        XCTAssertNotNil(sut.avatar)
    }
    
    func testHeroeEmpty() throws {
        sut.getHeroe(heroe: HeroeModel())
    }

}
