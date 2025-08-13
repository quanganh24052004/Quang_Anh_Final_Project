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
        
        view.backgroundColor = .background1
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        [pulseView, hrvView].forEach { v in
            v?.layer.cornerRadius = 16
            v?.layer.cornerCurve  = .continuous
            v?.layer.borderWidth  = 1
            v?.layer.borderColor  = UIColor.neutral4.cgColor
            v?.layer.masksToBounds = true
        }
        
        addLogButton.buttonPrimary.setTitle(NSLocalizedString("Add", comment: ""), for: .normal)
        
        addLogButton.addTarget(self, action: #selector(addLog), for: .touchUpInside)
    }


    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func addLog() {
        view.endEditing(true)

        // Validate input
        guard let pText = pulseTF.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let hText = HRVTF.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let pulse = Int(pText), let hrv = Int(hText),
              (30...220).contains(pulse), hrv > 0 else {
            showAlert("Vui lòng nhập số hợp lệ. Ví dụ: Pulse 60–100, HRV > 0.")
            return
        }

        // Ghi vào Realm (dùng RealmManager ở trên)
        do {
            let entry = PulseEntry(pulse: pulse, hrv: hrv)
            try PulseLogRealmManager.add(entry)

            // Đóng màn thêm (Report sẽ tự reload qua NotificationToken)
            dismiss(animated: true)
        } catch {
            showAlert("Không lưu được vào Realm.\n\(error.localizedDescription)")
        }
    }

    private func showAlert(_ message: String) {
        let ac = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
