//
//  DetailsCoordinatorTests.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

import XCTest
@testable import NewsApp

final class NADetailsCoordinatorTests: XCTestCase {
    func testInitShouldSetNavigatorCorrectly() {
        let (sut, fakeNavigator, _) = makeSUT()

        XCTAssertEqual(sut.navigator, fakeNavigator)
    }

    func testStartFirstViewControllerShouldBeNADetailsViewController() {
        let (sut, _, _) = makeSUT()
        
        sut.start()
        
        XCTAssertNotNil(sut.navigator?.viewControllers.first as? NADetailsViewController)
    }
}

// MARK: - Helpers

extension NADetailsCoordinatorTests {
    private func makeSUT() -> (sut: NADetailsCoordinator,
                               fakeNavigator: UINavigationController,
                               routerSpy: NARouterSpy) {
        let fakeNavigator = UINavigationController()
        let routerSpy = NARouterSpy()
        let sut = NADetailsCoordinator(navigator: fakeNavigator, router: routerSpy, news: anyNewsDetails())

        return (sut, fakeNavigator, routerSpy)
    }
}
