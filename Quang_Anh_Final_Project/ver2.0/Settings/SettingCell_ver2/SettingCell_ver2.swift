//
//  SettingCell_ver2.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/13/25.
//

import UIKit

class SettingCell_ver2: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var imageSettingCell: UIImageView!
    
    @IBOutlet weak var titleSettingCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.backgroundColor = .background1
        super.layer.cornerRadius = 12
//        self.layer.masksToBounds = true
    }

    
    func configure(with item: SettingItem, isFirst: Bool, isLast: Bool) {
        imageSettingCell.image = item.icon
        titleSettingCell.text = item.title
        
        if isFirst && isLast {
            containerView.layer.cornerRadius = 12
            containerView.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner,
                .layerMinXMaxYCorner, .layerMaxXMaxYCorner
            ]
        } else if isFirst {
            containerView.layer.cornerRadius = 12
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if isLast {
            containerView.layer.cornerRadius = 12
            containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            containerView.layer.cornerRadius = 0
        }
    }
}
