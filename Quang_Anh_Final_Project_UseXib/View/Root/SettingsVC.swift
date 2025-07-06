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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        let leftItem = UIBarButtonItem(customView: settingsTitle)
        navigationItem.leftBarButtonItem = leftItem
    }
}

#Preview {
    SettingsVC()
}
