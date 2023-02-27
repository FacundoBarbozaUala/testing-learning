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

    @MainActor func makeSut() -> LoginRouter {
        let sut = LoginRouter()
        let mockLoginDemoViewType = MockLoginDemoViewType()
        let navigation = UINavigationController(rootViewController: mockLoginDemoViewType)
        sut.view = mockLoginDemoViewType
        mockLoginDemoViewType.beginAppearanceTransition(true, animated: false)
        return sut
    }
    
    func test_go_next_screen() async {
        let sut = await makeSut()
        
        await sut.goNextScreen()
        
        let topViewController = await sut.view?.navigationController?.topViewController
        let viewControllers = await sut.view?.navigationController?.viewControllers
        
        XCTAssertNotNil(topViewController)
        XCTAssertEqual(viewControllers?.count, 1)
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


