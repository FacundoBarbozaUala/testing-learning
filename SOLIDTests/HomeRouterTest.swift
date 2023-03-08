//
//  HomeRouterTest.swift
//  SOLIDTests
//
//  Created by Serena Donato on 07/03/2023.
//

import XCTest
@testable import SOLID
@testable import UalaCore

final class HomeRouterTest: XCTestCase {
    
    func makeSut() async -> (HomeRouter, UINavigationController) {
        let view = await UIViewController()
        let sut = HomeRouter(view: view)
        let navigation = await UINavigationController(rootViewController: sut.view!)
        return (sut, navigation)
    }
    
    func test_go_to_login() async {
        let (sut, navigation) = await makeSut()
        let spectedView = await UIViewController()
        await MainActor.run {
            spectedView.title = "Login"
            sut.view?.title = "Home"
        }
        
        await navigation.setViewControllers([spectedView, sut.view!], animated: true)
        let viewControllersNav = await navigation.viewControllers
        XCTAssertEqual(viewControllersNav.count, 2)
        
        await sut.goToLogin()
     
        await MainActor.run {
            XCTAssertTrue(navigation.topViewController != nil)
            XCTAssertEqual(navigation.viewControllers.count, 1)
            XCTAssertEqual(spectedView.title, navigation.topViewController?.title)
        }
    }
}
