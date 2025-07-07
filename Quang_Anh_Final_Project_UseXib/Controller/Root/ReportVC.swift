import UIKit

class ReportVC: UIViewController {

    // MARK: - Properties

    private var data: [PulseEntry] = []

    private let tabToLog = TabToLog()
    private let emptyLogView = EmptyLogView()
    private let dailyAdviceView = DailyAdviceView()
    
    private let logCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(LogCell.self, forCellWithReuseIdentifier: LogCell.identifier)
        return collectionView
    }()

    private let reportTitle: UILabel = {
        let label = UILabel()
        label.text = "Health Guru"
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.textColor = .title
        label.textAlignment = .left
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        updateViewState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        data = PulseEntry.loadAll()
        logCollectionView.reloadData()
        updateViewState()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .background

        // Navigation title
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: reportTitle)

        // Add views
        [tabToLog, logCollectionView, emptyLogView, dailyAdviceView].forEach { view.addSubview($0) }

        tabToLog.translatesAutoresizingMaskIntoConstraints = false
        logCollectionView.translatesAutoresizingMaskIntoConstraints = false
        emptyLogView.translatesAutoresizingMaskIntoConstraints = false
        dailyAdviceView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Tab to Log Button
            tabToLog.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 81),
            tabToLog.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Collection View
            logCollectionView.topAnchor.constraint(equalTo: tabToLog.bottomAnchor, constant: 24),
            logCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // Empty View
            emptyLogView.topAnchor.constraint(equalTo: logCollectionView.topAnchor),
            emptyLogView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyLogView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptyLogView.heightAnchor.constraint(equalToConstant: 80),
            
            dailyAdviceView.topAnchor.constraint(equalTo: emptyLogView.bottomAnchor, constant: 24),
            dailyAdviceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dailyAdviceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dailyAdviceView.heightAnchor.constraint(equalToConstant: 80),
        ])

        // Collection view config
        logCollectionView.dataSource = self
        logCollectionView.delegate = self
    }

    private func setupActions() {
        tabToLog.button.addTarget(self, action: #selector(goToLogVC), for: .touchUpInside)
    }

    // MARK: - State update

    private func updateViewState() {
        let isEmpty = data.isEmpty
        emptyLogView.isHidden = !isEmpty
        dailyAdviceView.isHidden = !isEmpty
        logCollectionView.isHidden = isEmpty
    }

    // MARK: - Navigation

    @objc private func goToLogVC() {
        let vc = LogVC()
        vc.hidesBottomBarWhenPushed = true
        vc.onAddEntry = { [weak self] entry in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension ReportVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LogCell.identifier, for: indexPath) as? LogCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: data[indexPath.item])
        return cell
    }
}



#Preview {
    ReportVC()
}
