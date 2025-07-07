//
//  SettingVC.swift
//  Quang_Anh_Final_Project_UseXib
//
//  Created by Nguyễn Quang Anh on 6/7/25.
//

import UIKit

class SettingsVC: UIViewController {
    
    private let settingsTitle: UILabel = {
        let title = UILabel()
        title.text = "Settings"
        title.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        title.textColor = .label
        title.textAlignment = .left
        title.sizeToFit()
        return title
    }()
    
    private let premiumButton = PremiumCustomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        let leftItem = UIBarButtonItem(customView: settingsTitle)
        navigationItem.leftBarButtonItem = leftItem
        
        setupPremiumButton()
    }
    
    private func setupPremiumButton() {
        view.addSubview(premiumButton)
        premiumButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            premiumButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            premiumButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            premiumButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //premiumButton.heightAnchor.constraint(equalToConstant: 104)
        ])
        
        premiumButton.onTapped = { [weak self] in
            let vc = PremiumDetailVC()
            vc.modalPresentationStyle = .automatic // hoặc .pageSheet, .formSheet, .fullScreen tùy trải nghiệm
            self?.present(vc, animated: true, completion: nil)
        }
    }
}

#Preview {
    SettingsVC()
}
