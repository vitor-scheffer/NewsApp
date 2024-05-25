//
//  SavedNewsCoordinatorTests.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

import XCTest
@testable import NewsApp

final class NASavedNewsCoordinatorTests: XCTestCase {
    func testInitShouldSetNavigatorCorrectly() {
        let (sut, fakeNavigator, _) = makeSUT()

        XCTAssertEqual(sut.navigator, fakeNavigator)
    }

    func testStartFirstViewControllerShouldBeNASavedNewsViewController() {
        let (sut, _, _) = makeSUT()
        
        sut.start()
        
        XCTAssertNotNil(sut.navigator?.viewControllers.first as? NASavedNewsViewController)
    }
    
    func testNavigateToDetailsShouldCallShowNewsDetails() {
        let (sut, fakeNavigator, routerSpy) = makeSUT()
        let expected = anyNewsDetails()

        sut.navigateToDetails(news: expected)

        XCTAssertTrue(routerSpy.showNewsDetailsCalled)
        XCTAssertEqual(routerSpy.navigator, fakeNavigator)
    }
}

// MARK: - Helpers

extension NASavedNewsCoordinatorTests {
    private func makeSUT() -> (sut: NASavedNewsCoordinator,
                               fakeNavigator: UINavigationController,
                               routerSpy: NARouterSpy) {
        let fakeNavigator = UINavigationController()
        let routerSpy = NARouterSpy()
        let sut = NASavedNewsCoordinator(navigator: fakeNavigator, router: routerSpy)

        return (sut, fakeNavigator, routerSpy)
    }
}
