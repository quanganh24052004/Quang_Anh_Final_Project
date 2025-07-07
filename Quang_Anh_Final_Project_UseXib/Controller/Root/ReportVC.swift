import UIKit

class ReportVC: UIViewController {
    private var data: [PulseEntry] = []
    
    let tabToLog = TabToLog()

    private let emptyLogView = EmptyLogView()
    
    private let logCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(LogCell.self, forCellWithReuseIdentifier: LogCell.identifier)
        return collectionView
    }()

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

        view.addSubview(tabToLog)
        tabToLog.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tabToLog.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 81),
            tabToLog.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        tabToLog.button.addTarget(self, action: #selector(goToLogVC), for: .touchUpInside)


        
        view.addSubview(logCollectionView)
        NSLayoutConstraint.activate([
            logCollectionView.topAnchor.constraint(equalTo: tabToLog.bottomAnchor, constant: 24),
            logCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        logCollectionView.dataSource = self
        logCollectionView.delegate = self
        
        view.addSubview(emptyLogView)
        emptyLogView.backgroundColor = .red
        emptyLogView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emptyLogView.topAnchor.constraint(equalTo: tabToLog.bottomAnchor, constant: 74),
            emptyLogView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyLogView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    @objc private func goToLogVC() {
        let vc = LogVC()
        vc.hidesBottomBarWhenPushed = true
        vc.onAddEntry = { [weak self] entry in
            self?.data.append(entry)
            self?.logCollectionView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ReportVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LogCell.identifier, for: indexPath) as? LogCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: data[indexPath.item])
        return cell
    }
    
    @objc func openLogVC() {
        let vc = LogVC()
        vc.onAddEntry = { [weak self] entry in
            self?.data.append(entry)
            self?.logCollectionView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}



#Preview {
    ReportVC()
}
