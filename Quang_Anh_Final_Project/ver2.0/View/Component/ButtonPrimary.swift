//
//  ButtonPrimary.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 7/24/25.
//

import UIKit

enum PrimaryButtonStyle {
    case primary1
    case neutral3
}

class ButtonPrimary: UIView {
    @IBOutlet weak var buttonPrimary: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
        buttonPrimary.layer.cornerRadius = 16
    }
    
    override func layoutSubviews() {
    }
    private func loadFromNib() {
        let nib = UINib(nibName: "ButtonPrimary", bundle: nil)
        let nibView = nib.instantiate(withOwner: self).first as! UIView
        addSubview(nibView)
        nibView.translatesAutoresizingMaskIntoConstraints = false
        nibView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nibView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nibView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nibView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nibView.layer.cornerRadius = 16
        nibView.backgroundColor = .clear
      }
    
    func setTitle(_ title: String) {
        buttonPrimary.setTitle(title, for: .normal)
    }

    func setEnabled(_ isEnabled: Bool) {
        buttonPrimary.isEnabled = isEnabled
        buttonPrimary.alpha = isEnabled ? 1.0 : 0.5
    }
    
    func addTarget(_ target: Any?, action: Selector, for event: UIControl.Event) {
        buttonPrimary.addTarget(target, action: action, for: event)
    }

    func setStyle(_ style: PrimaryButtonStyle) {
        switch style {
        case .primary1:
            buttonPrimary.backgroundColor = .buttonActive
            buttonPrimary.setTitleColor(.white, for: .normal)
            buttonPrimary.layer.borderWidth = 0
            buttonPrimary.isEnabled = true
            buttonPrimary.alpha = 1
        case .neutral3:
            buttonPrimary.backgroundColor = .buttonInactive
            buttonPrimary.setTitleColor(.white, for: .normal)
            buttonPrimary.layer.borderWidth = 0
            buttonPrimary.isEnabled = false
            buttonPrimary.alpha = 1
        }
    }

}

