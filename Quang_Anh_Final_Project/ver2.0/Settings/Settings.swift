//
//  Settings.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/3/25.
//

import UIKit

class Settings: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    // Dữ liệu của bạn (giữ nguyên action đã viết)
    private lazy var sections: [SettingSection] = [
        SettingSection(items: [
            SettingItem(icon: UIImage(named: "ic_profile"), title: "Profile", action: { [weak self] in
                guard let self = self else { return }
                if ProfileStorage.hasProfile() {
                    let vc = MyProfileVC()
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = ProfileVC()
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
        ]),
        SettingSection(items: [
            SettingItem(icon: UIImage(named: "ic_notify"), title: "Daily Reminder", action: { [weak self] in
                // ví dụ: mở màn hình cài đặt reminder
//                let vc = DailyReminderVC()
//                vc.hidesBottomBarWhenPushed = true
//                self?.navigationController?.pushViewController(vc, animated: true)
            }),
            SettingItem(icon: UIImage(named: "ic_changeAppIcon"), title: "Change App Icon", action: { [weak self] in
//                let vc = ChangeAppIconVC()
//                vc.hidesBottomBarWhenPushed = true
//                self?.navigationController?.pushViewController(vc, animated: true)
            }),
            SettingItem(icon: UIImage(named: "ic_lang"), title: "Language", action: { [weak self] in
//                let vc = LanguageVC()
//                vc.hidesBottomBarWhenPushed = true
//                self?.navigationController?.pushViewController(vc, animated: true)
            }),
        ]),
        SettingSection(items: [
            SettingItem(icon: UIImage(named: "ic_rate"), title: "Rate Us", action: {
//                guard let url = URL(string: "itms-apps://itunes.apple.com/app/idYOUR_APP_ID?action=write-review") else { return }
//                UIApplication.shared.open(url)
            }),
            SettingItem(icon: UIImage(named: "ic_feedback"), title: "Feedback", action: {
//                if let url = URL(string: "mailto:support@yourapp.com") {
//                    UIApplication.shared.open(url)
//                }
            }),
            SettingItem(icon: UIImage(named: "ic_privacyPolicy"), title: "Privacy Policy", action: {
//                if let url = URL(string: "https://your.site/privacy") {
//                    UIApplication.shared.open(url)
//                }
            }),
            SettingItem(icon: UIImage(named: "ic_termOfUser"), title: "Term of User", action: {
//                if let url = URL(string: "https://your.site/terms") {
//                    UIApplication.shared.open(url)
//                }
            }),
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background1
        setupTable()
    }
}

private extension Settings {
    func setupTable() {
        settingTableView.register(UINib(nibName: "SettingCell_ver2", bundle: nil),
                           forCellReuseIdentifier: "SettingCell_ver2")
        settingTableView.dataSource = self
        settingTableView.delegate   = self

        settingTableView.rowHeight = 56
        settingTableView.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 16)
        settingTableView.tableFooterView = UIView()
    }
}

extension Settings: UITableViewDataSource, UITableViewDelegate {

    // MARK: Sections & Rows
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }

    // MARK: Cell
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "SettingCell_ver2",
            for: indexPath
        ) as? SettingCell_ver2 else {
            return UITableViewCell()
        }

        let item   = sections[indexPath.section].items[indexPath.row]
        let isFirst = indexPath.row == 0
        let isLast  = indexPath.row == sections[indexPath.section].items.count - 1
        let onlyOne = isFirst && isLast

        cell.configure(with: item, isFirst: isFirst, isLast: isLast)

        cell.backgroundColor = .neutral5
        cell.contentView.backgroundColor = .neutral5

        // Bo góc full-width theo vị trí
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerCurve   = .continuous
        if onlyOne {
            cell.contentView.layer.cornerRadius = 12
            cell.contentView.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner,
                .layerMinXMaxYCorner, .layerMaxXMaxYCorner
            ]
        } else if isFirst {
            cell.contentView.layer.cornerRadius = 12
            cell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if isLast {
            cell.contentView.layer.cornerRadius = 12
            cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.contentView.layer.cornerRadius = 0
            cell.contentView.layer.maskedCorners = []
        }

        if isLast {
            cell.separatorInset = UIEdgeInsets(top: 0,
                                               left: tableView.bounds.width,
                                               bottom: 0, right: 0)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 16)
        }

        return cell
    }

    // MARK: Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].items[indexPath.row].action?()
    }

    // MARK: Section spacing = 16pt, không header/footer view
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 0.01 : 16
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { nil }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 0.01 }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { nil }
}
