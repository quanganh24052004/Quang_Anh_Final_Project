//
//  TitleIntro.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 7/24/25.
//

import UIKit

class TitleIntro: UIView {
    
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    override func layoutSubviews() {
    }
    private func loadFromNib() {
        let nib = UINib(nibName: "TitleIntro", bundle: nil)
        let nibView = nib.instantiate(withOwner: self).first as! UIView
        addSubview(nibView)
        nibView.translatesAutoresizingMaskIntoConstraints = false
        nibView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nibView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nibView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nibView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nibView.backgroundColor = .clear
    }

}
