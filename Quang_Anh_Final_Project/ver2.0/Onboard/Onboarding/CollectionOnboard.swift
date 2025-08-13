//
//  CollectionOnboard.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 7/24/25.
//

import UIKit

class CollectionOnboard: UIViewController {
    @IBOutlet weak var titleLabel: TitleIntro!
    @IBOutlet weak var collectionOnboard: UICollectionView!
    @IBOutlet weak var buttonContinue: ButtonPrimary!
    
    var selectedIndexes: Set<Int> = []
    var items: [OnboardItem] = [
        OnboardItem(title: "Heart Rate", imageName: "ic_heartRate"),
        OnboardItem(title: "High Blood Pressure", imageName: "ic_highBloodPressure"),
        OnboardItem(title: "Stress & Anxiety", imageName: "ic_stressAnxiety"),
        OnboardItem(title: "Low Energy Levels", imageName: "ic_lowEnergyLevels"),
    ]
    
    var onSelectionChanged: ((Int) -> Void)?
    var onContinue: ((Set<Int>) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background1
        navigationController?.isNavigationBarHidden = true
        titleLabel.title.text = "Which heart health issue\nconcerns you the most?"
        titleLabel.backgroundColor = .clear
        
        let nib = UINib(nibName: "CardViewCell", bundle: .main)
        collectionOnboard.register(nib, forCellWithReuseIdentifier: "cell")
        
        buttonContinue.buttonPrimary.setTitle("Continue", for: .normal)
        buttonContinue.setStyle(.neutral3)
        
        buttonContinue.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
        updateContinueButtonState()
        onSelectionChanged?(selectedIndexes.count)
    }

    private func updateContinueButtonState() {
        buttonContinue.setStyle(selectedIndexes.isEmpty ? .neutral3 : .primary1)
    }

//    @objc private func didTapContinue() {
//        onContinue?(selectedIndexes)
//    }
    
    @objc private func didTapPrimaryButton() {
        let nextVC = TabBar()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension CollectionOnboard: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CardViewCell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.row]
        cell.titleCard.text = item.title
        cell.imageCard.image = UIImage(named: item.imageName)
        // Gọi hàm cấu hình trạng thái chọn
        let isSelected = selectedIndexes.contains(indexPath.row)
        cell.configure(isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath.row) {
            selectedIndexes.remove(indexPath.row)
        } else {
            selectedIndexes.insert(indexPath.row)
        }
        collectionView.reloadData()
        updateContinueButtonState()
        onSelectionChanged?(selectedIndexes.count)
    }
    
    // MARK: - Layout: spacing giữa các cột
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    // MARK: - Layout: padding (inset)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    // MARK: - Layout: size cho mỗi item
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let spacing: CGFloat = 16
        let horizontalInsets: CGFloat = 16 * 2
        
        let totalSpacing = (numberOfColumns - 1) * spacing + horizontalInsets
        let itemWidth = floor((collectionView.bounds.width - totalSpacing) / numberOfColumns)
        
        return CGSize(width: itemWidth, height: 195)
    }
    

}
