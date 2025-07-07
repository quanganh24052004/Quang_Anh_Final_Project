//
//  LeftNavButton.swift
//  Quang_Anh_Final_Project_UseXib
//
//  Created by iKame Elite Fresher 2025 on 7/7/25.
//

import UIKit

class LeftNavButton: UIView {

    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.left")
        iv.tintColor = .tintTitle
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }

    private func setupView() {
        addSubview(iconImageView)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    @objc private func tapped() {
        onTap?()
    }

}

#Preview{
    LeftNavButton()
}
