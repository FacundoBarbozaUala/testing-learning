//
//  LoginStatus.swift
//  LoginExample
//
//  Created by Francisco Javier Saldivar Rubio on 29/10/22.
//

public protocol LoginStatus {
    func setLoginStatus(isLogged: Bool)
    func getLoginStatus() -> Bool
}

public final class LoginStatusDefault: LoginStatus {
    private var isLogged: Bool = false

    public func getLoginStatus() -> Bool {
        self.isLogged
    }

    public func setLoginStatus(isLogged: Bool) {
        self.isLogged = isLogged
    }
}
