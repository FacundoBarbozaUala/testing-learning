//
//  HomeRouter.swift
//  HomeExample
//
//  Created by Francisco Javier Saldivar Rubio on 29/10/22.
//

import UIKit

final class HomeRouter {
    var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension HomeRouter {
    @MainActor
    func goToLogin() {
        view?.navigationController?.popToRootViewController(animated: true)
    }
}
