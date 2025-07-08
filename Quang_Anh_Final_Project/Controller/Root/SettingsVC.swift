import UIKit

class SettingsVC: UIViewController {
    
    // MARK: DATA
    private var sections: [SettingSection] = []

    private let settingsTitle: UILabel = {
        let title = UILabel()
        title.text = "Settings"
        title.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        title.textColor = .label
        title.textAlignment = .left
        title.sizeToFit()
        return title
    }()

    private let premiumButton = PremiumCustomView()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        //tableView.separatorColor = UIColor(named: "red")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 16)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background

        let leftItem = UIBarButtonItem(customView: settingsTitle)
        navigationItem.leftBarButtonItem = leftItem

        setupPremiumButton()
        setupTableView()
        setupSections()
    }

    private func setupPremiumButton() {
        view.addSubview(premiumButton)
        premiumButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            premiumButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            premiumButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            premiumButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])

        premiumButton.onTapped = { [weak self] in
            let vc = PremiumDetailVC()
            vc.modalPresentationStyle = .automatic
            self?.present(vc, animated: true, completion: nil)
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: premiumButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupSections() {
        sections = [
            SettingSection(items: [
                SettingItem(icon: UIImage(named: "ic_profile"), title: "Profile", action: { [weak self] in
                    if ProfileStorage.hasProfile() {
                        let vc = MyProfileVC()
                        vc.hidesBottomBarWhenPushed = true
                        self?.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let vc = ProfileVC()
                        vc.hidesBottomBarWhenPushed = true
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                })
            ]),
            SettingSection(items: [
                SettingItem(icon: UIImage(named: "ic_notify"), title: "Daily Reminder", action: nil),
                SettingItem(icon: UIImage(named: "ic_changeAppIcon"), title: "Change App Icon", action: nil),
                SettingItem(icon: UIImage(named: "ic_lang"), title: "Language", action: nil)
            ]),
            SettingSection(items: [
                SettingItem(icon: UIImage(named: "ic_rate"), title: "Rate Us", action: nil),
                SettingItem(icon: UIImage(named: "ic_feedback"), title: "Feedback", action: nil),
                SettingItem(icon: UIImage(named: "ic_privacyPolicy"), title: "Privacy Policy", action: nil),
                SettingItem(icon: UIImage(named: "ic_termOfUser"), title: "Term of User", action: nil)
            ])
        ]
        tableView.reloadData()
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }

        let item = sections[indexPath.section].items[indexPath.row]
        cell.configure(icon: item.icon, title: item.title)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]
        item.action?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
#Preview {
    SettingsVC()
}
