//
//  DetailsPresenterTests.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

import XCTest
@testable import NewsApp

final class NADetailsPresenterTests: XCTestCase {
    func testInitWhenDoesntSetViewModel() {
        let (_, _, viewModelSpy) = makeSUT()

        XCTAssertFalse(viewModelSpy.setLoadingCalled)
        XCTAssertNil(viewModelSpy.newsDetails)
    }
    
    func testSetViewModelShouldSetValuesCorrectly() {
        let (sut, _, viewModelSpy) = makeSUT()
        let expected = anyNewsDetails()

        sut.setViewModel(viewModelSpy)

        XCTAssertTrue(viewModelSpy.setupLayoutCalled)
        XCTAssertNotNil(viewModelSpy.newsDetails)
        XCTAssertEqual(viewModelSpy.newsDetails, expected)
    }
}

// MARK: - Helpers

extension NADetailsPresenterTests {
    private func makeSUT() -> (sut: NADetailsPresenter,
                               coordinatorSpy: NADetailsCoordinatorSpy,
                               viewModelSpy: NADetailsViewModelSpy) {
        let coordinatorSpy = NADetailsCoordinatorSpy()
        let viewModelSpy = NADetailsViewModelSpy()
        let sut = NADetailsPresenter(coordinator: coordinatorSpy, news: anyNewsDetails())

        return (sut, coordinatorSpy, viewModelSpy)
    }
}
