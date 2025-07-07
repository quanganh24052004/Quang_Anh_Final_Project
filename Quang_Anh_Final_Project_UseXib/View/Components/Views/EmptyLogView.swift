//
//  EmptyLogView.swift
//  Quang_Anh_Final_Project_UseXib
//
//  Created by iKame Elite Fresher 2025 on 7/7/25.
//

import UIKit

class EmptyLogView: UIView {
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "heartIcon")
        imgView.tintColor = .buttonActive
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let pulseLabel: UILabel = {
        let label = UILabel()
        label.text = "Pulse"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .labelCell
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pulseValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-- bpm"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .text
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hrvLabel: UILabel = {
        let label = UILabel()
        label.text = "HRV"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .labelCell
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hrvValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-- ms"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .text
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .labelCell
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusValueLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .text
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 12
        self.backgroundColor = .white
        
        [imgView, pulseLabel, pulseValueLabel, hrvLabel, hrvValueLabel, statusLabel, statusValueLabel].forEach {
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),

            
            // Pulse
            pulseLabel.topAnchor.constraint(equalTo: imgView.topAnchor),
            pulseLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 12),
            pulseLabel.widthAnchor.constraint(equalToConstant: 80),
            
            pulseValueLabel.bottomAnchor.constraint(equalTo: imgView.bottomAnchor),
            pulseValueLabel.leadingAnchor.constraint(equalTo: pulseLabel.leadingAnchor),
            
            // HRV
            hrvLabel.topAnchor.constraint(equalTo: imgView.topAnchor),
            hrvLabel.leadingAnchor.constraint(equalTo: pulseLabel.trailingAnchor, constant: 12),
            hrvLabel.widthAnchor.constraint(equalToConstant: 80),
            
            hrvValueLabel.bottomAnchor.constraint(equalTo: imgView.bottomAnchor),
            hrvValueLabel.leadingAnchor.constraint(equalTo: hrvLabel.leadingAnchor),
            
            // Status
            statusLabel.topAnchor.constraint(equalTo: imgView.topAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: hrvLabel.trailingAnchor, constant: 12),
            statusLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -12),
            
            statusValueLabel.bottomAnchor.constraint(equalTo: imgView.bottomAnchor),
            statusValueLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor)
        ])
    }
}

#Preview {
    EmptyLogView()
}
