// MARK: - Import
import UIKit

class ProfileVC: UIViewController {
    
    // MARK: - Khai báo
    private let firstNameField: FormCV = {
        let field = FormCV(title: "First name", placeholder: "Enter first name...")
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private let lastNameField: FormCV = {
        let field = FormCV(title: "Last name", placeholder: "Enter last name...")
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private let weightField: FormCV = {
        let field = FormCV(title: "Weight", placeholder: "Enter your weight...")
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private let heightField: FormCV = {
        let field = FormCV(title: "Height", placeholder: "Enter your height...")
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Male", "Female"])
        segment.selectedSegmentIndex = 0
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    private let titleProfileVC: UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Thêm biến nhận dữ liệu userProfile
    public var userProfile: UserProfile?
    
    // MARK: - Stack Views
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 21
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nameStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let genderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let indexStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let addProfileButton: PrimaryButton = {
        let btn = PrimaryButton()
        btn.setTitle("Update")
        btn.setStyle(.buttonInactive)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        view.backgroundColor = .background
        navigationItem.titleView = titleProfileVC
        setupUI()
        setupLeftNavButton()
        setupValidationEvents()
        // Nếu có userProfile thì prefill dữ liệu
        if let profile = userProfile {
            firstNameField.textField.text = profile.firstName
            lastNameField.textField.text = profile.lastName
            weightField.textField.text = "\(profile.weight)"
            heightField.textField.text = "\(profile.height)"
            genderSegment.selectedSegmentIndex = profile.genderIndex
            updateButtonState()
        }
    }
    
    // MARK: - Setup Nav
    private func setupLeftNavButton() {
        let leftButtonView = LeftNavButton()
        leftButtonView.iconImageView.image = UIImage(systemName: "chevron.left")
        leftButtonView.onTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        let leftItem = UIBarButtonItem(customView: leftButtonView)
        navigationItem.leftBarButtonItem = leftItem
    }
    
    // MARK: - UI Setup Methods
    private func setupUI() {
        setupMainStack()
        setupAddProfileButton()
        setupConstraints()
    }
    private func setupMainStack() {
        view.addSubview(mainStack)
        nameStack.addArrangedSubview(firstNameField)
        nameStack.addArrangedSubview(lastNameField)
        genderStack.addArrangedSubview(genderLabel)
        genderStack.addArrangedSubview(genderSegment)
        indexStack.addArrangedSubview(weightField)
        indexStack.addArrangedSubview(heightField)
        mainStack.addArrangedSubview(nameStack)
        mainStack.addArrangedSubview(genderStack)
        mainStack.addArrangedSubview(indexStack)
    }
    private func setupAddProfileButton() {
        view.addSubview(addProfileButton)
        addProfileButton.addTarget(self, action: #selector(handleAddProfile), for: .touchUpInside)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addProfileButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addProfileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addProfileButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addProfileButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    // MARK: - Validation Setup
    private func setupValidationEvents() {
        [firstNameField.textField,
         lastNameField.textField,
         weightField.textField,
         heightField.textField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // Giới hạn tên tối đa 20 ký tự
        if textField == firstNameField.textField || textField == lastNameField.textField {
            if let text = textField.text, text.count > 20 {
                textField.text = String(text.prefix(20))
            }
        }
        
        updateButtonState()
    }
    
    @objc private func handleAddProfile() {
        guard
            let first = firstNameField.textField.text,
            let last = lastNameField.textField.text,
            let weightText = weightField.textField.text, let weight = Int(weightText),
            let heightText = heightField.textField.text, let height = Int(heightText)
        else { return }

        let gender = genderSegment.selectedSegmentIndex
        let profile = UserProfile(firstName: first, lastName: last, weight: weight, height: height, genderIndex: gender)

        ProfileStorage.save(profile)
        navigationController?.popViewController(animated: true)
    }
    private func updateButtonState() {
        guard
            let firstName = firstNameField.textField.text, !firstName.isEmpty,
            let lastName = lastNameField.textField.text, !lastName.isEmpty,
            let weightText = weightField.textField.text, let weight = Int(weightText), (16...200).contains(weight),
            let heightText = heightField.textField.text, let height = Int(heightText), (50...230).contains(height)
        else {
            addProfileButton.setStyle(.buttonInactive)
            return
        }
        
        addProfileButton.setStyle(.buttonActive)
    }
}

#Preview {
    ProfileVC()
}
