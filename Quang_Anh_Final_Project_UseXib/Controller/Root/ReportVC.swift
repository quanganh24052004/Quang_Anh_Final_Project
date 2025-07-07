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

        let leftItem = UIBarButtonItem(customView: reportTitle)
        navigationItem.leftBarButtonItem = leftItem
    }
}

#Preview {
    ReportVC()
}
