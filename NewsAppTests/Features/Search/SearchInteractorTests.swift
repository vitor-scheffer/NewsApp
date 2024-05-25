//
//  SearchInteractorTets.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

import XCTest
@testable import NewsApp

final class NASearchInteractorTests: XCTestCase {
    func testFetchNewsByQueryWhenReturnsSuccess() {
        let expected = anyNewsOutput()
        let (sut, apiStub, outputSpy) = makeSUT(status: .success(expected))
        
        sut.fetchNewsByQuery(anyNewsInput())

        XCTAssertTrue(outputSpy.fetchNewsSucceededCalled)
        XCTAssertNotNil(outputSpy.newsList)
        XCTAssertEqual(outputSpy.newsList, expected)
        XCTAssertTrue(apiStub.url!.contains("/everything?"))
        XCTAssertEqual(apiStub.method, .get)
    }
    
    func testFetchNewsByQueryWhenReturnsError() {
        let (sut, apiStub, outputSpy) = makeSUT(status: .failure(.generic))
        
        sut.fetchNewsByQuery(anyNewsInput())
        
        XCTAssertTrue(outputSpy.fetchNewsFailedCalled)
        XCTAssertNil(outputSpy.newsList)
        XCTAssertEqual(outputSpy.messageError, "Don't worry! We're already trying to solve this mistake, try again later")
        XCTAssertTrue(apiStub.url!.contains("/everything?"))
        XCTAssertEqual(apiStub.method!, .get)
    }
}

// MARK: - Helpers

extension NASearchInteractorTests {
    private func makeSUT(status: CompletionStatus<Decodable>) -> (sut: NASearchInteractor,
                                                                  apiStub: NewsApiStub,
                                                                  outputSpy: NASearchInteractorOutputSpy) {
        let apiStub = NewsApiStub(status: status)
        let outputSpy = NASearchInteractorOutputSpy()
        let sut = NASearchInteractor(api: apiStub, output: outputSpy)

        return (sut, apiStub, outputSpy)
    }
}
