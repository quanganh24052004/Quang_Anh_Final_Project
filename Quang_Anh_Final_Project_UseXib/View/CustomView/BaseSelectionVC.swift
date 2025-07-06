//
//  BaseSelectionVC.swift
//  Quang_Anh_Final_Project_UseXib
//
//  Created by Nguyễn Quang Anh on 5/7/25.
//

import UIKit

class BaseSelectionVC: UIViewController {

    // MARK: - Public Properties (override ở subclass)
    var pageTitle: String = ""
    var options: [CardOption] = []
    var onContinue: ((Set<Int>) -> Void)?

    private var selectedIndices: Set<Int> = []

    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        btn.setStyle(.buttonInactive)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        navigationItem.hidesBackButton = true

        titleLabel.text = pageTitle

        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(continueButton)

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
        continueButton.setStyle(selectedIndices.isEmpty ? .buttonInactive : .buttonActive)
    }

    @objc private func didTapContinue() {
        onContinue?(selectedIndices)
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension BaseSelectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
        cell.configure(option: options[indexPath.item], selected: selectedIndices.contains(indexPath.item))
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

