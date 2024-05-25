//
//  HomeInteractorTests.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

import XCTest
@testable import NewsApp

final class NAHomeInteractorTests: XCTestCase {
    func testFetchNewsWhenReturnsSuccess() {
        let expected = anyNewsOutput()
        let (sut, apiStub, outputSpy) = makeSUT(status: .success(expected))

        sut.fetchNews()

        XCTAssertTrue(outputSpy.fetchNewsSucceededCalled)
        XCTAssertNotNil(outputSpy.newsList)
        XCTAssertEqual(outputSpy.newsList, expected)
        XCTAssertTrue(apiStub.url!.contains("/top-headlines?country=us"))
        XCTAssertEqual(apiStub.method, .get)
        XCTAssertNil(apiStub.parameters)
    }
    
    func testFetchNewsWhenReturnsError() {
        let (sut, apiStub, outputSpy) = makeSUT(status: .failure(.generic))
        
        sut.fetchNews()
        
        XCTAssertTrue(outputSpy.fetchNewsFailedCalled)
        XCTAssertNil(outputSpy.newsList)
        XCTAssertEqual(outputSpy.messageError, "Don't worry! We're already trying to solve this mistake, try again later")
        XCTAssertTrue(apiStub.url!.contains("/top-headlines?country=us"))
        XCTAssertEqual(apiStub.method!, .get)
        XCTAssertNil(apiStub.parameters)
    }
    
    func testFetchNewsByQueryWhenReturnsSuccess() {
        let expected = anyNewsOutput()
        let (sut, apiStub, outputSpy) = makeSUT(status: .success(expected))
        
        sut.fetchNewsByQuery(anyCategoryInput())

        XCTAssertTrue(outputSpy.fetchNewsSucceededCalled)
        XCTAssertNotNil(outputSpy.newsList)
        XCTAssertEqual(outputSpy.newsList, expected)
        XCTAssertEqual(outputSpy.hasQuery, true)
        XCTAssertTrue(apiStub.url!.contains("/everything?"))
        XCTAssertEqual(apiStub.method, .get)
        XCTAssertNotNil(apiStub.parameters)
    }
}

// MARK: - Helpers

extension NAHomeInteractorTests {
    private func makeSUT(status: CompletionStatus<Decodable>) -> (sut: NAHomeInteractor,
                                                                  apiStub: NewsApiStub,
                                                                  outputSpy: NAHomeInteractorOutputSpy) {
        let apiStub = NewsApiStub(status: status)
        let outputSpy = NAHomeInteractorOutputSpy()
        let sut = NAHomeInteractor(api: apiStub, output: outputSpy)

        return (sut, apiStub, outputSpy)
    }
}
