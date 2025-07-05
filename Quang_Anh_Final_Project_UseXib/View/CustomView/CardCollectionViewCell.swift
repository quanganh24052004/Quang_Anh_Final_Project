import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "CardCollectionViewCell"
    
    let cardView = CardCustomView ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
        
    func configure(option: CardOption, selected: Bool){
        cardView.configure(with: option)
        cardView.isSelectedCard = selected
    }
}
    
#Preview {
    CardCollectionViewCell()
}

