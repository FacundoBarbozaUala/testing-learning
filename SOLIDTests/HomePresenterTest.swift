//
//  HomePresenterTest.swift
//  SOLIDTests
//
//  Created by Lucas Benitez on 08/03/2023.
//

import XCTest
@testable import UalaCore
@testable import SOLID

final class HomePresenterTest: XCTestCase {
    
    @MainActor
    func makeSut() -> (sut:HomePresenter, (mockInteractor: MockHomeInteractor, mockView: MockHomeViewController, mockHomeRouter: MockHomeRouter)) {
        let mockHomeInteractor = MockHomeInteractor()
        let mockHomeRouter = MockHomeRouter()
        let mockHomeVC = MockHomeViewController()
        let sut = HomePresenter(interactor: mockHomeInteractor, router: mockHomeRouter, view: mockHomeVC)
        return (sut,(mockHomeInteractor,mockHomeVC,mockHomeRouter))
    }
    
    func test_get_balance_success() async throws {
        let (sut,(mockHomeInteractor,mockHomeVC, _)) = await makeSut()
        var balanceSpected = Balance(accountId: "", availableBalance: 1)
        mockHomeInteractor.getBalanceStub = balanceSpected
        
        await sut.getBalance()
        
        await MainActor.run {
            XCTAssertTrue(mockHomeVC.setBalanceIsInvoked)
        }
    }
    
    func test_get_balance_failure() async throws {
        let (sut,(mockHomeInteractor,mockHomeVC, _)) = await makeSut()
        var errorSpected = UalaError.undefined
        mockHomeInteractor.getBalanceStubError = errorSpected
        
        await sut.getBalance()
        
        await MainActor.run {
            XCTAssertTrue(mockHomeVC.showErrorIsInvoked)
        }
    }
    
    func test_get_user_success() async throws {
        let (sut,(mockHomeInteractor,mockHomeVC, _)) = await makeSut()
        var userSpected = User(email: "")
        mockHomeInteractor.getUserStub = userSpected
        
        await sut.getUser()
        
        await MainActor.run {
            XCTAssertTrue(mockHomeVC.setUserIsInvoked)
        }
    }
    
    func test_get_user_failure() async throws {
        let (sut,(mockHomeInteractor,mockHomeVC, _)) = await makeSut()
        var errorSpected = UalaError.undefined
        mockHomeInteractor.getUserStubError = errorSpected
        
        await sut.getUser()
        
        await MainActor.run {
            XCTAssertTrue(mockHomeVC.showErrorIsInvoked)
        }
    }
    
    func test_unLogged() async throws {
        let (sut, (_, _, mockHomeRouter)) = await makeSut()
        
        sut.unLogged()
        
       _ = await sut.task?.result
        
        XCTAssertTrue(mockHomeRouter.goToLoginIsInvoked)
    }
    
    func test_homeStarted() async throws {
        let (sut,(mockHomeInteractor,mockHomeVC,mockHomeRouter)) = await makeSut()
        var balanceSpected = Balance(accountId: "", availableBalance: 1)
        mockHomeInteractor.getBalanceStub = balanceSpected
        var userSpected = User(email: "")
        mockHomeInteractor.getUserStub = userSpected
        
        sut.homeStarted()
        
        _ = await sut.task?.result
        
        XCTAssertTrue(mockHomeInteractor.getBalanceIsInvoked)
        XCTAssertTrue(mockHomeInteractor.getUserIsInvoked)
    }
    
}
class MockHomeInteractor: HomeInteractor {
    
    var getBalanceStub: Balance! = nil
    var getBalanceStubError: Error! = nil
    var getBalanceIsInvoked: Bool = false
    override func getBalance(completion: @escaping (Result<Balance, Error>) -> Void) {
        getBalanceIsInvoked = true
        if let getBalanceStubError = getBalanceStubError {
            completion(.failure(getBalanceStubError))
        } else {
            completion(.success(getBalanceStub))
        }
    }
    
    var getUserStub: User! = nil
    var getUserStubError: Error! = nil
    var getUserIsInvoked: Bool = false
    override func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        getUserIsInvoked = true
        if let getUserStubError = getUserStubError {
            completion(.failure(getUserStubError))
        } else {
            completion(.success(getUserStub))
        }
    }
}

class MockHomeRouter: HomeRouter {
    var goToLoginIsInvoked: Bool = false
    
    override func goToLogin() {
        goToLoginIsInvoked = true
    }
}

class MockHomeViewController: HomeViewController{
    var setBalanceIsInvoked: Bool = false
    override func setBalance(amount: Double) {
        setBalanceIsInvoked = true
    }
    
    var showErrorIsInvoked: Bool = false
    override func showError(error: Error) {
        showErrorIsInvoked = true
    }
    
    var setUserIsInvoked: Bool = false
    override func setUser(user: User) {
        setUserIsInvoked = true
    }
}
