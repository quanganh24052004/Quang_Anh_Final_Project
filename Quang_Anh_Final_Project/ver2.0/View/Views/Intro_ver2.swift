//
//  Intro_ver2.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 7/24/25.
//

import UIKit

class Intro_ver2: UIViewController {
    @IBOutlet weak var titleIntro: TitleIntro!
    @IBOutlet weak var titleButton: ButtonPrimary!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background1
        titleIntro.title.text = "Health Plan Pro"
        titleIntro.backgroundColor = .clear
        titleButton.buttonPrimary.setTitle("Continue", for: .normal)
        titleButton.setStyle(.primary1)
        
        titleButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
    }
    
    @objc private func didTapPrimaryButton() {
        let nextVC = CollectionOnboard()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}


