//
//  FormCV.swift
//  ProjectUIKit
//
//  Created by iKame Elite Fresher 2025 on 7/1/25.
//

// MARK: - Import
import UIKit

// MARK: - FormCV
class FormCV: UIView {
    
    // MARK: - Subviews
    private let label = UILabel()
    let textField = UITextField()
    
    private let stackView = UIStackView()
    
    // MARK: - Init
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        setupLabel(title: title)
        setupTextField(placeholder: placeholder)
        setupStackView()
        setUpConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel(title: "title")
        setupTextField(placeholder: "placeholder")
        setupStackView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel(title: "")
        setupTextField(placeholder: "")
        setupStackView()
        setUpConstraints()
    }
    
    // MARK: - Setup
    private func setupLabel(title: String) {
        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .text
    }
    
    private func setupTextField(placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.boxCard.cgColor
        textField.clipsToBounds = true
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        
        addSubview(stackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // TODO: Có thể thêm validate input hoặc custom UI cho textField
}

#Preview {
    FormCV()
}
