//
//  SearchPresenterTests.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

import XCTest
@testable import NewsApp

final class NASearchPresenterTests: XCTestCase {
    func testInitWhenDoesntSetViewModel() {
        let (_, _, _, viewModelSpy) = makeSUT()

        XCTAssertFalse(viewModelSpy.setLoadingCalled)
        XCTAssertFalse(viewModelSpy.setHeaderTitleCalled)
        XCTAssertFalse(viewModelSpy.setSearchMessageCalled)
    }

    func testSetViewModelShouldSetValuesCorrectly() {
        let (sut, _, _, viewModelSpy) = makeSUT()

        sut.setViewModel(viewModelSpy)

        XCTAssertTrue(viewModelSpy.setHeaderTitleCalled)
        XCTAssertEqual(viewModelSpy.headerText, "NewsApp")
        XCTAssertTrue(viewModelSpy.setSearchMessageCalled)
        XCTAssertEqual(viewModelSpy.message, "Search for specific news")
    }
    
    func testFetchNewsByQueryShouldCallInteractorFetchNewsByQuery() {
        let (sut, _, interactorSpy, viewModelSpy) = makeSUT()

        sut.fetchNewsByQuery("any-query")
        
        XCTAssertTrue(interactorSpy.fetchNewsByQueryCalled)
    }
    
    func testFetchNewsFailedShouldSetNewsFailed() {
        let (sut, _, _, viewModelSpy) = makeSUT()

        sut.setViewModel(viewModelSpy)
        sut.fetchNewsFailed("any")

        XCTAssertTrue(viewModelSpy.setNewsFailedCalled)
        XCTAssertEqual(viewModelSpy.messageError, "any")
    }
    
    func testFetchNewsByQuerySuccessWithEmptyListShouldSetSearchMessage() {
        let (sut, _, _, viewModelSpy) = makeSUT()
                
        sut.setViewModel(viewModelSpy)
        sut.fetchNewsSucceededWithEmptyList()
        
        XCTAssertTrue(viewModelSpy.setSearchMessageCalled)
        XCTAssertNil(viewModelSpy.newsList)
        XCTAssertNotNil(viewModelSpy.message)
        XCTAssertFalse(viewModelSpy.setNewsByQuerySuccessCalled)
        XCTAssertFalse(viewModelSpy.setNewsFailedCalled)
    }
    
    func testNewsSelectedShouldNavigateToDetails() {
        let (sut, coordinator, _, _) = makeSUT()
        let expected = anyNewsDetails()

        sut.newsSelected(expected)

        XCTAssertTrue(coordinator.navigateToDetailsCalled)
        XCTAssertEqual(coordinator.news, expected)
    }
}

// MARK: - Helpers

extension NASearchPresenterTests {
    private func makeSUT() -> (sut: NASearchPresenter,
                               coordinatorSpy: NASearchCoordinatorSpy,
                               interactorSpy: NASearchInteractorInputSpy,
                               viewModelSpy: NASearchViewModelSpy) {
        let coordinatorSpy = NASearchCoordinatorSpy()
        let interactorSpy = NASearchInteractorInputSpy()
        let viewModelSpy = NASearchViewModelSpy()
        let sut = NASearchPresenter(coordinator: coordinatorSpy, interactor: interactorSpy)

        return (sut, coordinatorSpy, interactorSpy, viewModelSpy)
    }
}
