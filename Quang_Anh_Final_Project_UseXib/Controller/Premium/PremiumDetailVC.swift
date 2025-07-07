//
//  PremiumDetailVC.swift
//  Quang_Anh_Final_Project_UseXib
//
//  Created by iKame Elite Fresher 2025 on 7/6/25.
//

import UIKit

class PremiumDetailVC: UIViewController {
    
    private let titlePremium: UILabel = {
        let label = UILabel()
        label.text = "Premium"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(titlePremium)
        
        NSLayoutConstraint.activate([
            titlePremium.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titlePremium.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
