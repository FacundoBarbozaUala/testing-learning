//
//  HomeRouter.swift
//  HomeExample
//
//  Created by Francisco Javier Saldivar Rubio on 29/10/22.
//

import UIKit

class HomeRouter {
    var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }

    @MainActor
    func goToLogin() {
        view?.navigationController?.popToRootViewController(animated: true)
    }
}
