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
    func makeSut() -> (sut:HomePresenter, (mockInteractor: MockHomeInteractor, mockView: MockHomeViewController)) {
        let mockHomeInteractor = MockHomeInteractor()
        let mockHomeRouter = MockHomeRouter()
        let mockHomeVC = MockHomeViewController()
        let sut = HomePresenter(interactor: mockHomeInteractor, router: mockHomeRouter, view: mockHomeVC)
        return (sut,(mockHomeInteractor,mockHomeVC))
    }
    
    func test_get_balance_success() async throws {
        let (sut,(mockHomeInteractor,mockHomeVC)) = await makeSut()
        var balanceSpected = Balance(accountId: "", availableBalance: 1)
        mockHomeInteractor.getBalanceStub = balanceSpected
        
        await sut.getBalance()
        
        await MainActor.run {
            XCTAssertTrue(mockHomeVC.setBalanceIsInvoked)
        }
    }
    
    func test_get_balance_failure() async throws {
        let (sut,(mockHomeInteractor,mockHomeVC)) = await makeSut()
        var errorSpected = UalaError.undefined
        mockHomeInteractor.getBalanceStubError = errorSpected
        
        await sut.getBalance()
        
        await MainActor.run {
            XCTAssertTrue(mockHomeVC.showErrorIsInvoked)
        }
    }
}
class MockHomeInteractor: HomeInteractor {
    var getBalanceIsInvoked: Bool = false
    var getBalanceStub: Balance! = nil
    var getBalanceStubError: Error! = nil
    override func getBalance(completion: @escaping (Result<Balance, Error>) -> Void) {
        if let getBalanceStubError = getBalanceStubError {
            completion(.failure(getBalanceStubError))
        } else {
            completion(.success(getBalanceStub))
        }
    }
}
class MockHomeRouter: HomeRouter {
    
}
class MockHomeViewController: HomeViewController{
    var setBalanceIsInvoked: Bool = false
    override func setBalance(amount: Double) {
        setBalanceIsInvoked = true
    }
    
    var showErrorIsInvoked: Bool = false
    //var errorStub
    override func showError(error: Error) {
        showErrorIsInvoked = true
    }
}
