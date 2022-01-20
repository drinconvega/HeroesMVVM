//
//  HeroeListTests.swift
//  HeroesMVVMTests
//
//  Created by Daniel Rincon Vega on 20/1/22.
//

import XCTest
@testable import HeroesMVVM

class HeroeListTests: XCTestCase {

    let sut : HeroeListVM = HeroeListVM(apiSession: APISessionMock(), dataManager: DataManagerMock())
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowLoadMore() throws {
        //Como hay datos en db, entra por db y ahi se mostraria
        sut.getHeroeList()
        XCTAssertTrue(sut.showLoadMore)
        
        //Incrementa el valor de page.offset y setea a false porque llegan menos de 30
        sut.getHeroesListFromServer()
        XCTAssertFalse(sut.showLoadMore)
        //Probamos si tiene el comportamiento correcto al llamar aqui y no entra por la condicion de buscar en la bd de nuevo
        sut.getHeroeList()
        XCTAssertFalse(sut.showLoadMore)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
