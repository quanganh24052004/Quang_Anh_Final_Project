//
//  LogCell.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/12/25.
//

import UIKit

class LogCell_ver2: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var pulseValue: UILabel!
    @IBOutlet weak var bpm: UILabel!
    
    @IBOutlet weak var hvrValue: UILabel!
    @IBOutlet weak var ms: UILabel!

    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 16
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
