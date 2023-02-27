//
//  LoginRouter.swift
//  LoginExample
//
//  Created by Francisco Javier Saldivar Rubio on 29/10/22.
//

import UalaAuth

final class LoginRouter: LoginDemoRouterType {
    var view: LoginDemoViewType?

    func goNextScreen() {
        view?.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
}
