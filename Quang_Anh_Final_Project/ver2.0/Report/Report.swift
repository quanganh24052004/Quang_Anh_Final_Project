//
//  Report.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/3/25.
//

import UIKit

class Report: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background1
        
        // Do any additional setup after loading the view.
    }

    @IBAction func tapToLog(sender: Any) {
        let addLogVC = AddLog(nibName: "AddLog", bundle: nil)
        addLogVC.modalPresentationStyle = .fullScreen   // iOS 13+: dạng sheet/card
        addLogVC.modalTransitionStyle = .coverVertical // hiệu ứng trượt lên
        present(addLogVC, animated: true)
    }
}
