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

