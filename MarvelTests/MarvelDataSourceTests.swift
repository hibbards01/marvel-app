//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Hibbard Family on 6/20/22.
//

import XCTest
import Swinject
import Combine
import Alamofire
@testable import Marvel

final class MarvelDataSourceTests: XCTestCase {
    var container: Container!
    var subscription: AnyCancellable?
    var mockSessionContainer: MockSessionContainer<ComicModel>!
    
    override func setUpWithError() throws {
        let assembiles = Assembler([
            MarvelAssembly()
        ])
        container = assembiles.resolver as? Container
        
        // Override with the mock session.
        mockSessionContainer = .init()
        container.register(SessionContainer.self) { [unowned self] _ in
            self.mockSessionContainer
        }
    }
    
    func testPublisherSuccess() {
        let expectation = XCTestExpectation(description: "MarvelDataSourceTests.testPublisherSuccess")
        guard let dataSource = container.resolve(MarvelDataSource<ComicModel>.self) else {
            XCTFail("Unable to resolve data source from Swinject.")
            return
        }
        subscription = dataSource.data.sink { result in
            if case .success(let comics) = result {
                XCTAssertEqual(mockComicModels, comics)
            } else {
                XCTFail("Failed to send a Result.success.")
            }
            
            expectation.fulfill()
        }
        
        // Setup the mock and send the request.
        mockSessionContainer.setSuccess(response: mockResponse)
        dataSource.request()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testPublisherFailure() {
        let expectation = XCTestExpectation(description: "MarvelDataSourceTests.testPublisherSuccess")
        guard let dataSource = container.resolve(MarvelDataSource<ComicModel>.self) else {
            XCTFail("Unable to resolve data source from Swinject.")
            return
        }
        subscription = dataSource.data.sink { result in
            if case .failure(let error) = result,
               case .explicitlyCancelled = error {
                XCTAssert(true)
            } else {
                XCTFail("Failed to send a Result.failure.")
            }
            
            expectation.fulfill()
        }
        
        // Setup the mock and send the request.
        mockSessionContainer.setFailure()
        dataSource.request()
        
        wait(for: [expectation], timeout: 1.0)
    }
}
