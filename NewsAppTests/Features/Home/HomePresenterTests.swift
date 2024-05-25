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
    
    func testFetchNewsSuccessShouldNotSetNewsSuccessByQuery() {
        let (sut, _, _, viewModelSpy) = makeSUT()
        let expected = anyNewsOutput()
                
        sut.setViewModel(viewModelSpy)
        sut.fetchNewsSucceeded(expected, hasQuery: false)
        
        XCTAssertFalse(viewModelSpy.setNewsByQuerySuccessCalled)
        XCTAssertNil(viewModelSpy.querySearched)
    }
    
    func testFetchNewsFailedShouldSetNewsFailed() {
        let (sut, _, _, viewModelSpy) = makeSUT()

        sut.setViewModel(viewModelSpy)
        sut.fetchNewsFailed("any")

        XCTAssertTrue(viewModelSpy.setNewsFailedCalled)
        XCTAssertEqual(viewModelSpy.messageError, "any")
    }
    
    func testFetchNewsByQueryShouldCallInteractorFetchNewsByQuery() {
        let (sut, _, interactor, _) = makeSUT()

        sut.fetchNewsByQuery(.topHeadlines)

        XCTAssertTrue(interactor.fetchNewsByQueryCalled)
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
