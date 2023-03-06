//
//  LoginStatusDefaultTest.swift
//  SOLIDTests
//
//  Created by Serena Donato on 17/02/2023.
//

import XCTest
@testable import SOLID

final class LoginStatusDefaultTest: XCTestCase {

    func makeSut() -> LoginStatus {
        let sut = LoginStatusDefault()
        return sut
    }
    
    func test_set_login_status_true() throws {
        // Arrange precondiciones, declaracion de variables
        let sut = makeSut()
        let stubStatus = true
        
        // Act
        sut.setLoginStatus(isLogged: stubStatus)
        
        // Assert
        XCTAssertEqual(sut.getLoginStatus(), stubStatus)
    }
    
    func test_set_login_status_false() throws {
        // Arrange precondiciones, declaracion de variables
        let sut = makeSut()
        let stubStatus = false
        
        // Act
        sut.setLoginStatus(isLogged: stubStatus)
        
        // Assert
        XCTAssertEqual(sut.getLoginStatus(), stubStatus)
    }
    
    func test_set_login_status_default() throws {
        // Arrange precondiciones, declaracion de variables
        let sut = makeSut()
        
        // Assert
        XCTAssertEqual(sut.getLoginStatus(), false)
    }
}
