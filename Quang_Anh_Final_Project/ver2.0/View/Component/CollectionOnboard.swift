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
    
    // Thay vì selectedIndex, dùng Set để lưu nhiều index được chọn
    var selectedIndexes: Set<Int> = []
    var items: [OnboardItem] = [
        OnboardItem(title: "High Blood Pressure", imageName: "ic_highBloodPressure"),
        OnboardItem(title: "Heart Rate", imageName: "ic_heartRate"),
        OnboardItem(title: "Reduce Stress", imageName: "ic_reduceStress"),
        // Thêm các item khác tùy ý, imageName phải đúng tên trong asset
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background1
        titleLabel.title.text = "Which heart health issue\nconcerns you the most?"
        titleLabel.backgroundColor = .clear
        
        let nib = UINib(nibName: "CardViewCell", bundle: .main)
        collectionOnboard.register(nib, forCellWithReuseIdentifier: "cell")
        
        buttonContinue.buttonPrimary.setTitle("Continue", for: .normal)
        buttonContinue.setStyle(.buttonInactive)
        
        buttonContinue.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
    }

    @objc private func didTapPrimaryButton() {
        // Chuyển màn
        let nextVC = SelectionVC1()
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
    }
    
    // MARK: - Layout: spacing giữa các cột
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16 // spacing giữa các cột
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16 // spacing giữa các hàng
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
        let horizontalInsets: CGFloat = 16 * 2 // left + right
        
        let totalSpacing = (numberOfColumns - 1) * spacing + horizontalInsets
        let itemWidth = floor((collectionView.bounds.width - totalSpacing) / numberOfColumns)
        
        return CGSize(width: itemWidth, height: 195) // tùy chỉnh chiều cao
    }
}
//extension CollectionOnboard: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        users.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardViewCell
//        
//        let item = users[indexPath.row]
//        cell.titleCard.text = item.name
//        cell.imageCard.image = UIImage(named: item.avatar)
//        
//        return cell
//    }
//}
