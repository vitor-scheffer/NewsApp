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
    
    func testFetchNewsShouldFetchNews() {
        let (sut, _, interactorSpy, _) = makeSUT()

        sut.fetchNews()
        
        XCTAssertTrue(interactorSpy.fetchNewsCalled)
    }
    
    func testFetchNewsFailedShouldSetNewsFailed() {
        let (sut, _, _, viewModelSpy) = makeSUT()

        sut.setViewModel(viewModelSpy)
        sut.fetchNewsFailed("any")

        XCTAssertTrue(viewModelSpy.setNewsFailedCalled)
        XCTAssertEqual(viewModelSpy.messageError, "any")
    }
    
    func testNewsSelectedShouldNavigateToDetails() {
        let (sut, coordinator, _, _) = makeSUT()
        var expected = anyNewsDetails()

        sut.newsSelected(expected)

        XCTAssertTrue(coordinator.navigateToDetailsCalled)
        XCTAssertEqual(coordinator.news, expected)
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
