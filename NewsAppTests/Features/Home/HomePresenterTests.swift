//
//  HomePresenterTests.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

import XCTest
@testable import NewsApp

final class NAHomePresenterTests: XCTestCase {
    func testInitWhenDoesntSetViewModel() {
        let (_, _, interactorSpy, viewModelSpy) = makeSUT()

        XCTAssertFalse(viewModelSpy.setLoadingCalled)
        XCTAssertFalse(viewModelSpy.setHeaderTitleCalled)
        XCTAssertFalse(interactorSpy.fetchNewsCalled)
    }

    func testSetViewModelShouldSetValuesCorrectly() {
        let (sut, _, interactorSpy, viewModelSpy) = makeSUT()

        sut.setViewModel(viewModelSpy)

        XCTAssertTrue(viewModelSpy.setHeaderTitleCalled)
        XCTAssertEqual(viewModelSpy.headerText, "NewsApp")
        XCTAssertTrue(interactorSpy.fetchNewsCalled)
    }
}

// MARK: - Helpers

extension NAHomePresenterTests {
    private func makeSUT() -> (sut: NAHomePresenter,
                               coordinatorSpy: NAHomeCoordinatorSpy,
                               interactorSpy: NAHomeInteractorInputSpy,
                               viewModelSpy: NAHomeViewModelSpy) {
        let coordinatorSpy = NAHomeCoordinatorSpy()
        let interactorSpy = NAHomeInteractorInputSpy()
        let viewModelSpy = NAHomeViewModelSpy()
        let sut = NAHomePresenter(coordinator: coordinatorSpy, interactor: interactorSpy)

        return (sut, coordinatorSpy, interactorSpy, viewModelSpy)
    }
}
