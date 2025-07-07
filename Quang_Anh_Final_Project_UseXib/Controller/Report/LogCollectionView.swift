import UIKit

class LogCollectionView: UICollectionView {
    // Khởi tạo layout mặc định
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 80)
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupCollection()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollection() {
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        register(LogCell.self, forCellWithReuseIdentifier: LogCell.identifier)
    }
}
