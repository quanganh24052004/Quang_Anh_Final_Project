//
//  MainTabBarVC.swift
//  Quang_Anh_Final_Project_UseXib
//
//  Created by Nguyễn Quang Anh on 6/7/25.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let reportVC = ReportVC()
        let settingVC = SettingsVC()

            reportVC.tabBarItem = UITabBarItem(title: "Report",
                                             image: UIImage(systemName: "heart.text.clipboard"),
                                             selectedImage: UIImage(systemName: "heart.text.clipboard.fill"))

            settingVC.tabBarItem = UITabBarItem(title: "Setting",
                                                image: UIImage(systemName: "gearshape"),
                                                selectedImage: UIImage(systemName: "gearshape.fill"))

            let nav1 = UINavigationController(rootViewController: reportVC)
            let nav2 = UINavigationController(rootViewController: settingVC)

            viewControllers = [nav1, nav2]
        }
}
