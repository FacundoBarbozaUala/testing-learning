//
//  TwoSectionOnboardingViewController.swift
//  UalaUI
//
//  Created by Laura Krayacich on 07/04/2021.
//

import UIKit

public class TwoSectionOnboardingViewController: BaseViewController, TwoSectionOnboardingViewProtocol {

    // MARK: Outlets
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var feeInfoLabel: UILabel!
    
    // MARK: Properties
    public var twoSectionOnboardingPresenter: TwoSectionOnboardingPresenter?
    public var hideSecondButton = true
    public var channel: String = ""
    
    // MARK: Lifecicle
    open override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
    // MARK: private functions
    private func customizeUI() {
        navigationController?.navigationBar.tintColor = UalaStyle.colors.blue80
        backgroundView.backgroundColor = UalaStyle.colors.grey05
        
        if let title = twoSectionOnboardingPresenter?.dataModel?.title {
            titleLabel?.text = title
            titleLabel.customize(style: .blackTitle)
        }
        
        mainButton.setTitle(twoSectionOnboardingPresenter?.dataModel?.mainButtonTitle, for: .normal)
        if let buttonStyle = twoSectionOnboardingPresenter?.dataModel?.mainButtonStyle {
            mainButton?.customize(style: buttonStyle)
        }
        
        secondButton.setTitle(twoSectionOnboardingPresenter?.dataModel?.secondButtonTitle, for: .normal)
        if let buttonStyle = twoSectionOnboardingPresenter?.dataModel?.secondButtonStyle {
            secondButton?.customize(style: buttonStyle)
        }
        
        secondButton.isHidden = hideSecondButton
        
        if let feeInfoText = twoSectionOnboardingPresenter?.dataModel?.feeInformation {
            feeInfoLabel.customize(style: .regularFareSecondaryCenter(size: 14))
            feeInfoLabel.isHidden = feeInfoText.isEmpty
            feeInfoLabel.text = feeInfoText
        }
        
        customizeTable()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customizeNavigationBar()
    }

    private func customizeNavigationBar() {
        navigationController?.setupTitle(color: .black)
    }
    
    private func customizeTable() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(TwoSectionOnboardingStepsCell.self)
        tableView?.register(TwoSectionOnboardingInfoCell.self)
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.sectionHeaderHeight = 50
        tableView?.separatorStyle = .none
    }
    
    public override func customizeNavigation() {
        super.customizeNavigation()
        navigationController?.navigationBar.tintColor = UalaStyle.colors.blue50
        
        if twoSectionOnboardingPresenter?.didShowHelpButton ?? false {
            customizeNavigationButtons()
        }
    }
    
    private func customizeNavigationButtons() {
        addHelpButtonIntoNavBar()
    }
    
    private func addHelpButtonIntoNavBar() {
        let infoImage: UIImage? = BundleImage(bundle: .Common, named: "outline-helpCircle-global")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: infoImage,
            style: .plain,
            target: self,
            action: #selector(actionRightButton)
        )
    }
    
    @objc func actionRightButton() {
        twoSectionOnboardingPresenter?.didShowHelp()
    }

    @IBAction func mainButtonTapped(_ sender: Any) {
        twoSectionOnboardingPresenter?.didClickMainButton()
    }
    
    @IBAction func secondButtonTapped(_ sender: Any) {
        twoSectionOnboardingPresenter?.didClickSecondButton(channel: channel)
    }
}

// MARK: TableView
extension TwoSectionOnboardingViewController: UITableViewDataSource, UITableViewDelegate {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.1 : 60
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else {
            return UIView()
        }
        
        let view = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = twoSectionOnboardingPresenter?.getModelSubtitle()
        titleLabel.customize(style: .semiBoldSubtitleLeft)
        titleLabel.numberOfLines = 0

        view.addSubview(titleLabel)
        
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        
        return view
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoSectionOnboardingPresenter?.numberOfRowsIn(section: section) ?? 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let buttonText = twoSectionOnboardingPresenter?.itemsInSection(indexPath.section)[indexPath.row].buttonText
        
        if buttonText.isEmpty {
            return 80
        } else {
            return 100
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemsInSection = twoSectionOnboardingPresenter?.itemsInSection(indexPath.section), !(itemsInSection.isEmpty) else {
            return UITableViewCell()
        }
        return returnCell(tableView: tableView, indexPath: indexPath, sectionItems: itemsInSection)
    }
    
    private func returnCell(tableView: UITableView, indexPath: IndexPath, sectionItems: [TwoSectionOnboardingField]) -> UITableViewCell {
        let item = sectionItems[indexPath.row]
        let type = item.fieldType
        switch type {
        case .step: return stepTableViewCell(tableView: tableView, indexPath: indexPath, item: item)
        case .info: return infoTableViewCell(tableView: tableView, indexPath: indexPath, item: item)
        }
    }
    
    private func infoTableViewCell(tableView: UITableView, indexPath: IndexPath, item: TwoSectionOnboardingField) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TwoSectionOnboardingInfoCell
        cell.configure(with: item)
        cell.twoSectionOnboardingPresenter = twoSectionOnboardingPresenter
        return cell
    }
    
    private func stepTableViewCell(tableView: UITableView, indexPath: IndexPath, item: TwoSectionOnboardingField) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TwoSectionOnboardingStepsCell
        cell.configure(with: item)
        cell.twoSectionOnboardingPresenter = twoSectionOnboardingPresenter
        return cell
    }
}
