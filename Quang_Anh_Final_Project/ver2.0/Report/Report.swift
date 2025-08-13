//
//  Report.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/3/25.
//

import UIKit
import RealmSwift

class Report: UIViewController {
    
    @IBOutlet weak var logData: UITableView!
    
    private var token: NotificationToken?
    private var results: Results<PulseEntryObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background1
        logData.dataSource = self
        logData.delegate = self
        logData.rowHeight = UITableView.automaticDimension
        logData.estimatedRowHeight = 80
        logData.register(UINib(nibName: "LogCell_ver2", bundle: nil),
                         forCellReuseIdentifier: "LogCell_ver2")
        
        do {
            results = try RealmManager.all()
            // Quan sát thay đổi để reload tự động
            token = results.observe { [weak self] _ in
                self?.logData.reloadData()
            }
        } catch {
            print("Realm error: \(error)")
        }
    }
    
    deinit { token?.invalidate() }
    
    @IBAction func tapToLog(sender: Any) {
        let addLogVC = AddLog(nibName: "AddLog", bundle: nil)
        addLogVC.modalPresentationStyle = .fullScreen   // iOS 13+: dạng sheet/card
        addLogVC.modalTransitionStyle = .coverVertical // hiệu ứng trượt lên
        present(addLogVC, animated: true)
    }
    
}

extension Report: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 12 }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell_ver2", for: indexPath) as! LogCell_ver2
        let obj = results[indexPath.section]   // ⬅️ quan trọng

        cell.pulseValue.text = "\(obj.pulse)"
        cell.pulseValue.textColor = obj.statusColor
        cell.bpm.textColor = obj.statusColor
        cell.hvrValue.text = "\(obj.hrv)"
        cell.hvrValue.textColor = obj.statusColor
        cell.ms.textColor = obj.statusColor
        cell.statusLabel.textColor = obj.statusColor
        cell.statusLabel.text = obj.status.rawValue
    
        return cell
    }

//     Xoá
//    func tableView(_ tableView: UITableView,
//                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = UIContextualAction(style: .destructive, title: "Xoá") { _,_,done in
//            do {
//                try RealmManager.delete(self.results[indexPath.row])
//                done(true)
//            } catch {
//                print("Delete error: \(error)")
//                done(false)
//            }
//        }
//        return UISwipeActionsConfiguration(actions: [delete])
//    }
}
