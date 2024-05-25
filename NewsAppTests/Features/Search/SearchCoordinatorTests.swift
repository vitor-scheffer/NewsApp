//
//  SearchCoordinatorTests.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

import XCTest
@testable import NewsApp

final class NASearchCoordinatorTests: XCTestCase {
    func testInitShouldSetNavigatorCorrectly() {
        let (sut, fakeNavigator, _) = makeSUT()

        XCTAssertEqual(sut.navigator, fakeNavigator)
    }

    func testStartFirstViewControllerShouldBeNASearchViewController() {
        let (sut, _, _) = makeSUT()

        sut.start()

        XCTAssertNotNil(sut.navigator?.viewControllers.first as? NASearchViewController)
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

extension NASearchCoordinatorTests {
    private func makeSUT() -> (sut: NASearchCoordinator,
                               fakeNavigator: UINavigationController,
                               routerSpy: NARouterSpy) {
        let fakeNavigator = UINavigationController()
        let routerSpy = NARouterSpy()
        let sut = NASearchCoordinator(navigator: fakeNavigator, router: routerSpy)

        return (sut, fakeNavigator, routerSpy)
    }
}
