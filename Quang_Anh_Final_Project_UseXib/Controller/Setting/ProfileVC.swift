import UIKit

class ProfileVC: UIViewController {
    
    // MARK: - Khai báo
    private let firstNameField = FormCV(title: "First name", placeholder: "Enter first name...")
    private let lastNameField = FormCV(title: "Last name", placeholder: "Enter last name...")
    private let weightField = FormCV(title: "Weight", placeholder: "Enter your weight...")
    private let `heightField` = FormCV(title: "Height", placeholder: "Enter your height...")
    /// Segment
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .text
        return label
    }()
    
    private var genderSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Male", "Female"])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    /// Title
    
    private let titleProfileVC: UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .title
        return label
    }()
    

    // MARK: Stack Views
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
        
        view.backgroundColor = .background
        navigationItem.titleView = titleProfileVC
        
//        let leftItem = UIBarButtonItem(customView: titleProfileVC)
//        navigationItem.leftBarButtonItem = leftItem
        setupLeftNavButton()
        setupLayout()
    }
    
    // MARK: FUNCTION
    private func setupLeftNavButton() {
        let leftButtonView = LeftNavButton()
        leftButtonView.iconImageView.image = UIImage(systemName: "chevron.left")
        leftButtonView.onTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        let leftItem = UIBarButtonItem(customView: leftButtonView)
        navigationItem.leftBarButtonItem = leftItem
    }
    
    // MARK: - Constraints
    private func setupLayout() {
        // Add subviews
        view.addSubview(mainStack)
        
        // Add arranged subviews to each stack
        nameStack.addArrangedSubview(firstNameField)
        nameStack.addArrangedSubview(lastNameField)
        
        genderStack.addArrangedSubview(genderLabel)
        genderStack.addArrangedSubview(genderSegment)
        
        indexStack.addArrangedSubview(weightField)
        indexStack.addArrangedSubview(heightField)
        
        mainStack.addArrangedSubview(nameStack)
        mainStack.addArrangedSubview(genderStack)
        mainStack.addArrangedSubview(indexStack)
        view.addSubview(addProfileButton)
        // Constraints
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
}

#Preview {
    ProfileVC()
}
