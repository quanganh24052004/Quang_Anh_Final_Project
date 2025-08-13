//
//  Report.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/3/25.
//

import UIKit
import RealmSwift

class Report: UIViewController {
    
    private let emptyLogView = EmptyLogView()
    private let dailyAdviceView = DailyAdviceView()
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
        
        // Add the empty label to the view, centered
        [emptyLogView, dailyAdviceView].forEach { view.addSubview($0) }
        emptyLogView.translatesAutoresizingMaskIntoConstraints = false
        dailyAdviceView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Empty View
            emptyLogView.topAnchor.constraint(equalTo: logData.topAnchor),
            emptyLogView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyLogView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptyLogView.heightAnchor.constraint(equalToConstant: 80),
            
            dailyAdviceView.topAnchor.constraint(equalTo: emptyLogView.bottomAnchor, constant: 24),
            dailyAdviceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dailyAdviceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dailyAdviceView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        do {
            results = try PulseLogRealmManager.all()
            // Observe changes to reload automatically
            token = results.observe { [weak self] _ in
                self?.logData.reloadData()
                self?.updateTableViewVisibility()
            }
            updateTableViewVisibility()
        } catch {
            print("Realm error: \(error)")
        }
    }
    
    deinit { token?.invalidate() }
    
    @IBAction func tapToLog(sender: Any) {
        let addLogVC = AddLog(nibName: "AddLog", bundle: nil)
        addLogVC.modalPresentationStyle = .fullScreen
        addLogVC.modalTransitionStyle = .coverVertical
        present(addLogVC, animated: true)
    }

    private func updateTableViewVisibility() {
        let isEmpty = (results?.count ?? 0) == 0
        logData.isHidden = isEmpty
        emptyLogView.isHidden = !isEmpty
        dailyAdviceView.isHidden = !isEmpty
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
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Xoá") { _,_,done in
            do {
                try PulseLogRealmManager.delete(self.results[indexPath.row])
                done(true)
            } catch {
                print("Delete error: \(error)")
                done(false)
            }
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

