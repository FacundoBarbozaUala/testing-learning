//
//  HomeInteractorTest.swift
//  SOLIDTests
//
//  Created by Lucas Benitez on 01/03/2023.
//

import XCTest
import PromiseKit
@testable import SOLID
@testable import UalaCore
import UalaUI

final class HomeInteractorTest: XCTestCase {
    func makeSut() -> (sut: HomeInteractor, spy: MockProfileRepository) {
        let mockProfile = MockProfileRepository()
        let enviroment = EnvironmentBuilder.create(.stage, .Argentina)
        let sut = HomeInteractor(profileRepo: mockProfile)
        CoreStarter.start(environment: enviroment)
        UIStarter.start(from: .init())
        ServiceLocator.sharedLocator.register({MockAPIManager() as BaseApiManager})
        return (sut, mockProfile)
    }
    
    func test_get_balance_success() {
        let (sut,spy) = makeSut()
        var balanceSpected = Balance(accountId: "", availableBalance: 1)
        spy.balanceStub = balanceSpected
        let expectation = XCTestExpectation(description: "Promise resolved")
        
        sut.getBalance { result in
            switch result {
            case .success(let balance):
                XCTAssertEqual(balance, balanceSpected)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_get_balance_failure() {
        let (sut,spy) = makeSut()
        spy.balanceStubError = UalaError.undefined
        let expectation = XCTestExpectation(description: "Promise resolved")
        
        sut.getBalance { result in
            switch result {
            case .success(_):
                XCTFail()
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, spy.balanceStubError.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_get_user_success() {
        let (sut, spy) = makeSut()
        var userSpected = User(email: "")
        spy.detailsStub = userSpected
        let expectation = XCTestExpectation(description: "Promise resolved")
        
        sut.getUser { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user, userSpected)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_get_user_failure() {
        let (sut,spy) = makeSut()
        spy.detailsStubError = UalaError.undefined
        let expectation = XCTestExpectation(description: "Promise resolved")
        
        sut.getUser { result in
            switch result {
            case .success(_):
                XCTFail()
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, spy.detailsStubError.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
}

extension Balance: Equatable {
    public static func == (lhs: UalaCore.Balance, rhs: UalaCore.Balance) -> Bool {
        return lhs.accountId == rhs.accountId && lhs.availableBalance == rhs.availableBalance && lhs.balanceData == rhs.balanceData
    }
}

extension User: Equatable {
    public static func == (lhs: UalaCore.User, rhs: UalaCore.User) -> Bool {
        return lhs.userId == rhs.userId && lhs.email == rhs.email
    }
}


class MockProfileRepository: ProfileRepository {
    
    var detailsIsInvoked: Bool = false
    var detailsStub: User! = nil
    var detailsStubError: Error! = nil
    override func details() -> Promise<User> {
        if let detailsStubError = detailsStubError {
            return .init(error: detailsStubError)
        }
        return .value(detailsStub)
    }
    
    var balanceIsInvoked: Bool = false
    var balanceStub: Balance! = nil
    var balanceStubError: Error! = nil
    override func balance() -> Promise<Balance> {
        if let balanceStubError = balanceStubError {
            return .init(error: balanceStubError)
        }
        return Promise.value(balanceStub)
    }
}

class MockAPIManager: BaseApiManager {
    
}
