//
//  HomeViewControllerTest.swift
//  SOLIDTests
//
//  Created by Serena Donato on 14/03/2023.
//

import XCTest
@testable import UalaCore
@testable import SOLID

final class HomeViewControllerTest: XCTestCase {
    
    func makeSut() async -> (sut: HomeViewController, spy: (MockHomePresenter, UINavigationController)) {
        let mockHomePresenter = MockHomePresenter()
        let sut = await HomeViewController(presenter: mockHomePresenter)
        let navigation = await UINavigationController(rootViewController: sut)
        return (sut, (mockHomePresenter, navigation))
    }
    
    func test_view_did_load() async {
        let (sut, (mockHomePresenter, navigation)) = await makeSut()
        let rightBarButton = await UIBarButtonItem(title: "Logout")
        
        await sut.viewDidLoad()
        
        await MainActor.run {
            XCTAssertEqual(rightBarButton.title, sut.navigationItem.rightBarButtonItem?.title)
            XCTAssertTrue(mockHomePresenter.homeStartedIsInvoked)
        }
    }
    
    func test_logOut() async {
        let (sut, (mockHomePresenter, navigation)) = await makeSut()
        let spectedView = await UIViewController()
        await MainActor.run {
            spectedView.title = "Login"
            sut.title = "Home"
        }
        
        await navigation.setViewControllers([spectedView, sut], animated: true)
        let viewControllersNav = await navigation.viewControllers
        XCTAssertEqual(viewControllersNav.count, 2)
        
        await sut.logOut()
        
        await MainActor.run {
            XCTAssertTrue(navigation.topViewController != nil)
            XCTAssertEqual(navigation.viewControllers.count, 1)
            XCTAssertEqual(spectedView.title, navigation.topViewController?.title)
        }
    }
}

class MockHomePresenter: HomePresenter {
    var homeStartedIsInvoked: Bool = false
    
    override func homeStarted() {
        homeStartedIsInvoked = true
    }
}
