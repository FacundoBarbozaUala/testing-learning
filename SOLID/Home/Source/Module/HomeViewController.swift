//
//  HomeViewController.swift
//  HomeExample
//
//  Created by Francisco Javier Saldivar Rubio on 29/10/22.
//

import UalaUI
import UIKit
import UalaCore

class HomeViewController: UIViewController {
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(named: "home_background")
        return imageView
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UalaStyle.font.h1ExtraLight
        return label
    }()
    
    private let presenter: HomePresenter = HomePresenter()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style:         UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        let rightBarButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logOut))
        rightBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButton
        setup()
        presenter.homeStarted()
    }
    
    @objc func logOut() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(backgroundView)
        view.addSubview(balanceLabel)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            balanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            view.trailingAnchor.constraint(equalTo: balanceLabel.trailingAnchor, constant: 40),
            balanceLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setBalance(amount: Double) {
        balanceLabel.text = String.strCurrency(from: amount)
    }
    
    func showError(error: Error) {
        print("💥: \(error)")
    }
    
    func setUser(user: User) {
        print("👤: \n userID: \(user.userId) \n name: \(user.fullName) \n email: \(user.email)")
    }
}
