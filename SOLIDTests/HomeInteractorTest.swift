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
        let sut = HomeInteractor()
        let mockProfile = MockProfileRepository()
        let enviroment = EnvironmentBuilder.create(.stage, .Argentina)
        CoreStarter.start(environment: enviroment)
        UIStarter.start(from: .init())
        ServiceLocator.sharedLocator.register({MockAPIManager() as BaseApiManager})
        return (sut, mockProfile)
    }
    
    func test_get_balance_success() {
        let (sut,spy) = makeSut()
        let balanceSpected = Balance(accountId: "", availableBalance: 1)
        
        sut.getBalance { [weak self] result in
            switch result {
            case .success(let balance):
                XCTAssertEqual(balance, balanceSpected)
            case .failure(let error):
                XCTFail()
            }
        }
    }
    
    func test_get_balance_failure() {
        let (sut,spy) = makeSut()
        let errorSpected = UalaError(rawValue: "Falló")
        
        sut.getBalance { [weak self] result in
            switch result {
            case .success(let balance):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(errorSpected?.localizedDescription, error.localizedDescription)
            }
        }
    }
}
extension Balance: Equatable {
    public static func == (lhs: UalaCore.Balance, rhs: UalaCore.Balance) -> Bool {
        return lhs.accountId == rhs.accountId && lhs.availableBalance == rhs.availableBalance && lhs.balanceData == rhs.balanceData
    }
}

class MockProfileRepository: ProfileRepository {
    
    var detailsIsInvoked: Bool = false
    public func details() {
        detailsIsInvoked = true
    }
    
    var balanceIsInvoked: Bool = false
    let balanceStub: Balance!
    let balanceStubError: Error!
    override func balance() -> Promise<Balance> {
        if let balanceStubError = balanceStubError {
            return .init(error: balanceStubError)
        }
        return .value(balanceStub)
    }
}

class MockAPIManager: BaseApiManager {
    
}
