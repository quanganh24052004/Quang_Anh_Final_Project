import UIKit

class MyProfileVC: UIViewController {

    // MARK: - UI Components
    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.circle.fill")
        iv.tintColor = UIColor(named: "buttonActive")?.withAlphaComponent(1) ?? .systemRed
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(named: "title")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bmiCardView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.05
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowRadius = 8
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let bmiTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your BMI:"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bmiValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 64, weight: .bold)
        label.textColor = UIColor(named: "good")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // Button Editing kế thừa từ PrimaryButton
    private let editButton: PrimaryButton = {
        let btn = PrimaryButton()
        btn.setTitle("Editing")
        btn.setStyle(.buttonActive)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        title = "Profile"
        setupLeftNavButton()
        setupDeleteButton()
        setupLayout()
        loadProfile()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProfile()
    }

    // MARK: - UI Setup
    private func setupLayout() {
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(bmiCardView)
        view.addSubview(editButton)
        
        bmiCardView.addSubview(bmiTitleLabel)
        bmiCardView.addSubview(bmiValueLabel)
        bmiCardView.addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bmiCardView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            bmiCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bmiCardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
            bmiCardView.heightAnchor.constraint(equalToConstant: 160),
            
            bmiTitleLabel.topAnchor.constraint(equalTo: bmiCardView.topAnchor, constant: 16),
            bmiTitleLabel.centerXAnchor.constraint(equalTo: bmiCardView.centerXAnchor),
            
            bmiValueLabel.topAnchor.constraint(equalTo: bmiTitleLabel.bottomAnchor, constant: 4),
            bmiValueLabel.centerXAnchor.constraint(equalTo: bmiCardView.centerXAnchor),
            
            infoStack.topAnchor.constraint(equalTo: bmiValueLabel.bottomAnchor, constant: 12),
            infoStack.leadingAnchor.constraint(equalTo: bmiCardView.leadingAnchor, constant: 12),
            infoStack.trailingAnchor.constraint(equalTo: bmiCardView.trailingAnchor, constant: -12),
            infoStack.bottomAnchor.constraint(equalTo: bmiCardView.bottomAnchor, constant: -12),
            
            editButton.topAnchor.constraint(equalTo: bmiCardView.bottomAnchor, constant: 32),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            editButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        // Add info items to infoStack
        let infoTitles = ["Weight", "Height", "Gender"]
        let infoValues = ["--", "--", "--"]
        for i in 0..<3 {
            let vStack = UIStackView()
            vStack.axis = .vertical
            vStack.alignment = .center
            vStack.spacing = 2
            vStack.translatesAutoresizingMaskIntoConstraints = false
            
            let valueLabel = UILabel()
            valueLabel.text = infoValues[i]
            valueLabel.font = .systemFont(ofSize: 20, weight: .semibold)
            valueLabel.textColor = UIColor(named: "good")
            valueLabel.textAlignment = .center
            valueLabel.tag = 100 + i // Để cập nhật sau
            
            let titleLabel = UILabel()
            titleLabel.text = infoTitles[i]
            titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
            titleLabel.textColor = UIColor(named: "subtitle")
            titleLabel.textAlignment = .center
            
            vStack.addArrangedSubview(valueLabel)
            vStack.addArrangedSubview(titleLabel)
            infoStack.addArrangedSubview(vStack)
        }
        
        // Action cho nút Editing
        editButton.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
    }
    
    private func setupLeftNavButton() {
        let leftButtonView = LeftNavButton()
        leftButtonView.iconImageView.image = UIImage(systemName: "chevron.left")
        leftButtonView.onTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        let leftItem = UIBarButtonItem(customView: leftButtonView)
        navigationItem.leftBarButtonItem = leftItem
    }
    
    private func setupDeleteButton() {
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
        trashButton.tintColor = UIColor(named: "buttonActive")
        navigationItem.rightBarButtonItem = trashButton
    }

    // MARK: - Profile Logic
    private func loadProfile() {
        guard let profile = ProfileStorage.get() else {
            nameLabel.text = "No profile"
            bmiValueLabel.text = "--"
            for i in 0..<3 {
                if let v = infoStack.arrangedSubviews[i] as? UIStackView,
                   let valueLabel = v.arrangedSubviews.first as? UILabel {
                    valueLabel.text = "--"
                }
            }
            return
        }
        nameLabel.text = "\(profile.firstName) \(profile.lastName)"
        // BMI tính toán
        let heightM = Double(profile.height) / 100.0
        let bmi = heightM > 0 ? Double(profile.weight) / (heightM * heightM) : 0
        bmiValueLabel.text = String(format: "%.1f", bmi)
        // Cập nhật infoStack
        let infoValues: [String] = [
            "\(profile.weight) kg",
            "\(profile.height) cm",
            profile.genderIndex == 0 ? "Male" : "Female"
        ]
        for i in 0..<3 {
            if let v = infoStack.arrangedSubviews[i] as? UIStackView,
               let valueLabel = v.arrangedSubviews.first as? UILabel {
                valueLabel.text = infoValues[i]
            }
        }
    }

    @objc private func didTapDelete() {
        let alert = UIAlertController(
            title: "Confirm Deletion",
            message: "Are you sure you want to delete your profile?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            ProfileStorage.clear()
            self.showDeleteSuccessAlert()
        })
        present(alert, animated: true)
    }

    private func showDeleteSuccessAlert() {
        let alert = UIAlertController(
            title: "Deleted",
            message: "Your profile has been deleted.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }

    @objc private func didTapEdit() {
        // Chuyển sang ProfileVC để chỉnh sửa
        let profileVC = ProfileVC()
        if let profile = ProfileStorage.get() {
            profileVC.userProfile = profile
        }
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}

#Preview{
    MyProfileVC()
}
