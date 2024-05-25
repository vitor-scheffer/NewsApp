//
//  SavedNewsPresenterTests.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

import XCTest
@testable import NewsApp

final class NASavedNewsPresenterTests: XCTestCase {
    func testInitWhenDoesntSetViewModel() {
        let (_, _, interactorSpy, viewModelSpy) = makeSUT()

        XCTAssertFalse(viewModelSpy.setLoadingCalled)
        XCTAssertFalse(viewModelSpy.setHeaderTitleCalled)
        XCTAssertFalse(interactorSpy.fetchNewsCalled)
    }

    func testSetViewModelShouldSetValuesCorrectly() {
        let (sut, _, _, viewModelSpy) = makeSUT()

        sut.setViewModel(viewModelSpy)

        XCTAssertTrue(viewModelSpy.setHeaderTitleCalled)
        XCTAssertEqual(viewModelSpy.headerText, "NewsApp")
    }
    
    func testViewWillAppearShouldFetchNews() {
        let (sut, _, interactorSpy, _) = makeSUT()

        sut.viewWillAppear(true)
        
        XCTAssertTrue(interactorSpy.fetchNewsCalled)
    }
    
    func testFetchNewsShouldFetchNews() {
        let (sut, _, interactorSpy, _) = makeSUT()

        sut.fetchNews()
        
        XCTAssertTrue(interactorSpy.fetchNewsCalled)
    }
    
    func testFetchNewsSucceededShouldSetNewsSuccess() {
        let (sut, _, _, viewModelSpy) = makeSUT()

        sut.setViewModel(viewModelSpy)
        sut.fetchNewsSucceededWithEmptyList()

        XCTAssertTrue(viewModelSpy.setNewsListEmptyCalled)
        XCTAssertNil(viewModelSpy.newsList)
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
        let expected = anyNewsDetails()

        sut.newsSelected(expected)

        XCTAssertTrue(coordinator.navigateToDetailsCalled)
        XCTAssertEqual(coordinator.news, expected)
    }
}

// MARK: - Helpers

extension NASavedNewsPresenterTests {
    private func makeSUT() -> (sut: NASavedNewsPresenter,
                               coordinatorSpy: NASavedNewsCoordinatorSpy,
                               interactorSpy: NASavedNewsInteractorInputSpy,
                               viewModelSpy: NASavedNewsViewModelSpy) {
        let coordinatorSpy = NASavedNewsCoordinatorSpy()
        let interactorSpy = NASavedNewsInteractorInputSpy()
        let viewModelSpy = NASavedNewsViewModelSpy()
        let sut = NASavedNewsPresenter(coordinator: coordinatorSpy, interactor: interactorSpy)

        return (sut, coordinatorSpy, interactorSpy, viewModelSpy)
    }
}
