//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 15/05/24.
//

import XCTest
@testable import NewsApp

final class NAHomeCoordinatorTests: XCTestCase {
    func testInitShouldSetNavigatorCorrectly() {
        let (sut, fakeNavigator, _) = makeSUT()

        XCTAssertEqual(sut.navigator, fakeNavigator)
    }

    func testStartFirstViewControllerShouldBeNAHomeViewController() {
        let (sut, _, _) = makeSUT()

        sut.start()

        XCTAssertNotNil(sut.navigator?.viewControllers.first as? NAHomeViewController)
    }

    func testShowTransactionsShouldCallTransactions() {
        let (sut, fakeNavigator, routerSpy) = makeSUT()
        let expected = anyNewsDetails()

        sut.navigateToDetails(news: expected)

        XCTAssertTrue(routerSpy.showNewsDetailsCalled)
        XCTAssertEqual(routerSpy.navigator, fakeNavigator)
        
    }
}

// MARK: - Helpers

extension NAHomeCoordinatorTests {
    private func makeSUT() -> (sut: NAHomeCoordinator,
                               fakeNavigator: UINavigationController,
                               routerSpy: NARouterSpy) {
        let fakeNavigator = UINavigationController()
        let routerSpy = NARouterSpy()
        let sut = NAHomeCoordinator(navigator: fakeNavigator, router: routerSpy)

        return (sut, fakeNavigator, routerSpy)
    }
}
