//
//  LoginRouterTest.swift
//  SOLIDTests
//
//  Created by Serena Donato on 27/02/2023.
//

import XCTest
import UalaAuth
@testable import SOLID

final class LoginRouterTest: XCTestCase {
    
    func makeSut() async -> (LoginRouter, UINavigationController) {
        let sut = LoginRouter()
        let mockLoginDemoViewType = await MockLoginDemoViewType()
        sut.view = mockLoginDemoViewType
        let navigation = await UINavigationController(rootViewController: sut.view!)
        return (sut, navigation)
    }
    
    func test_go_next_screen() async throws {
        let (sut, navigation) = await makeSut()
        let viewControllerSpected = await HomeViewController()
      
        await sut.goNextScreen()
        
        let topViewController = await navigation.topViewController
        let viewControllers = await navigation.viewControllers
        
        XCTAssertNotNil(topViewController)
        XCTAssertEqual(topViewController, viewControllerSpected)
        XCTAssertEqual(viewControllers.count, 2)
    }
}

class MockLoginDemoViewType: UIViewController, LoginDemoViewType {
    var presenter: UalaAuth.LoginDemoPresenterType?
    
    func show(message: String) {
        
    }
    
    func loading(_ value: Bool) {
        
    }
    
    func show(alert: UIAlertController) {
    }
}


