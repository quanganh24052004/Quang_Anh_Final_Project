import UIKit

class SelectionVC2: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What would you like to achieve?"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var options: [CardOption] = [
        CardOption(title: "Improve Heart Health", imageName: "ic_f2_sl1"),
        CardOption(title: "Improve blood pressure health", imageName: "ic_f2_sl2"),
        CardOption(title: "Reduce Stress", imageName: "ic_f2_sl3"),
        CardOption(title: "Increase Energy Levels", imageName: "ic_f2_sl4")
    ]
    
    private var selectedIndices: Set<Int> = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let continueButton: PrimaryButton = {
        let btn = PrimaryButton()
        btn.setTitle("Continue")
        btn.setStyle(.buttonInactive) // mặc định disable
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(continueButton)
        
        // Add Target
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        setupConstraints()
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -16),

            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func updateContinueButtonState() {
        if selectedIndices.isEmpty {
            continueButton.setStyle(.buttonInactive)
        } else {
            continueButton.setStyle(.buttonActive)
        }
    }
    
    @objc private func didTapContinue() {
        print("Tiếp tục với các lựa chọn: \(selectedIndices)")
        let nextVC = SelectionVC3() // Thay bằng màn hình kế tiếp của bạn
        navigationController?.pushViewController(nextVC, animated: true)
    }
        
}

// MARK: - UICollectionViewDataSource & Delegate
extension SelectionVC2: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
        let isSelected = selectedIndices.contains(indexPath.item)
        cell.configure(option: options[indexPath.item], selected: isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndices.contains(indexPath.item) {
            selectedIndices.remove(indexPath.item)
        } else {
            selectedIndices.insert(indexPath.item)
        }
        collectionView.reloadItems(at: [indexPath])
        updateContinueButtonState()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 12) / 2
        return CGSize(width: width, height: 195)
    }
}

#Preview {
    SelectionVC2()
}
