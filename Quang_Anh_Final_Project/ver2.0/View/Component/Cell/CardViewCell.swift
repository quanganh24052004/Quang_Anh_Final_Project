//
//  CardViewCell.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 7/24/25.
//

import UIKit

class CardViewCell: UICollectionViewCell {

    @IBOutlet weak var tickBox: UIImageView!
    @IBOutlet weak var titleCard: UILabel!
    @IBOutlet weak var imageCard: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        imageCard.layer.cornerRadius = 16
        imageCard.layer.masksToBounds = true
    }
    
    func configure(isSelected: Bool) {
        if isSelected {
            tickBox.image = UIImage(named: "ic_tickOn")
            self.layer.borderColor = UIColor(named: "primary1")?.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 20
        } else {
            tickBox.image = UIImage(named: "ic_tick")
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0
        }
    }
}
