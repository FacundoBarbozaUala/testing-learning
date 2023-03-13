//
//  HomePresenter.swift
//  HomeExample
//
//  Created by Francisco Javier Saldivar Rubio on 29/10/22.
//

final class HomePresenter {
    
    let interactor: HomeInteractor
    let router: HomeRouter
    weak var view: HomeViewController?
    var task: Task<Void, Error>?
    
    init(interactor: HomeInteractor = HomeInteractor(), router: HomeRouter = HomeRouter() , view: HomeViewController? = nil) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    deinit {
        task?.cancel()
    }
}

extension HomePresenter {
    
    func homeStarted() {
        task = Task {
            await getBalance()
            await getUser()
        }
    }
    
    @MainActor
    func getBalance() {
        interactor.getBalance { [weak self] result in
            switch result {
            case .success(let balance):
                self?.view?.setBalance(amount: balance.availableBalance)
            case .failure(let error):
                self?.view?.showError(error: error)
            }
        }
    }
    
    @MainActor
    func getUser() {
        interactor.getUser { result in
            switch result {
            case .success(let user):
                self.view?.setUser(user: user)
            case .failure(let error):
                self.view?.showError(error: error)
            }
        }
    }
    
    func unLogged() {
        task = Task {
            await router.goToLogin()
        }
    }
    
}
