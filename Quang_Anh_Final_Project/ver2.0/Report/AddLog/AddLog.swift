//
//  AddLog.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/3/25.
//

import UIKit

class AddLog: UIViewController {
    @IBOutlet weak var pulseView: UIView!
    @IBOutlet weak var hrvView: UIView!
    
    @IBOutlet weak var pulseTF: UITextField!
    @IBOutlet weak var HRVTF: UITextField!
    
    @IBOutlet weak var addLogButton: ButtonPrimary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Screen
        view.backgroundColor = .background1
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        [pulseView, hrvView].forEach { v in
            v?.layer.cornerRadius = 16
            v?.layer.cornerCurve  = .continuous
            v?.layer.borderWidth  = 1
            v?.layer.borderColor  = UIColor.neutral4.cgColor
            v?.layer.masksToBounds = true   // cần clip theo bo góc
            v?.backgroundColor = .systemBackground
        }
        
        addLogButton.buttonPrimary.setTitle(NSLocalizedString("Add", comment: ""), for: .normal)
        
        addLogButton.addTarget(self, action: #selector(addLog), for: .touchUpInside)
        
        
    }


    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func addLog() {
        
    }
}
