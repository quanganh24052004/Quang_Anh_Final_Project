//
//  SettingCellTableViewCell.swift
//  Quang_Anh_Final_Project_UseXib
//
//  Created by iKame Elite Fresher 2025 on 7/7/25.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    static let identifier = "SettingsCell"
    
    private let iconView: UIImageView = {
        let img = UIImageView()
        img.tintColor = .buttonActive
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowView: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "chevron.compact.right"))
        img.tintColor = .buttonActive
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        //contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        setupLayout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupLayout() {
        [iconView, titleLabel, arrowView].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            arrowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowView.widthAnchor.constraint(equalToConstant: 24),
            arrowView.heightAnchor.constraint(equalTo: arrowView.widthAnchor)
        ])
    }
    
    func configure(icon: UIImage?, title: String) {
        iconView.image = icon
        titleLabel.text = title
    }

}

#Preview{
    SettingsCell()
}
