//
//  ReportVC.swift
//  Quang_Anh_Final_Project_UseXib
//
//  Created by Nguyễn Quang Anh on 6/7/25.
//

import UIKit

class ReportVC: UIViewController {

    private let reportTitle: UILabel = {
        let title = UILabel()
        title.text = "Health Guru"
        title.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        title.textColor = .title
        title.textAlignment = .left
        title.sizeToFit()
        return title
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background

        // LeftTilte
        let leftItem = UIBarButtonItem(customView: reportTitle)
        navigationItem.leftBarButtonItem = leftItem
        
        // Button add Log
        let tabToLog = TabToLog()
            view.addSubview(tabToLog)
            tabToLog.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                tabToLog.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 81),
                tabToLog.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
            
            tabToLog.button.addTarget(self, action: #selector(goToLogVC), for: .touchUpInside)
    }
    
    @objc private func goToLogVC() {
        let vc = LogVC()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}



#Preview {
    ReportVC()
}
