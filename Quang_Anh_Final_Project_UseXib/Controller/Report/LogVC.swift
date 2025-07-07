import UIKit

class LogVC: UIViewController {

    var onAddEntry: ((PulseEntry) -> Void)? // closure để trả dữ liệu về
    
    // MARK: SETUP VIEW
    // Pulse Stack
    private let pulseLabel: UILabel = {
        let label = UILabel()
        label.text = "Pulse"
        label.textColor = .tintTitle
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    private let pulseField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Pulse"
        field.borderStyle = .roundedRect
        return field
    }()

    private lazy var pulseStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pulseLabel, pulseField])
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()

    // MARK: - HRV Stack
    private let hrvLabel: UILabel = {
        let label = UILabel()
        label.text = "HRV"
        label.textColor = .tintTitle
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    private let hrvField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter HRV"
        field.borderStyle = .roundedRect
        return field
    }()

    private lazy var hrvStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hrvLabel, hrvField])
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()

    // MARK: - Horizontal Stack
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pulseStack, hrvStack])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let addButton: PrimaryButton = {
        let btn = PrimaryButton()
        btn.setTitle("Add")
        btn.setStyle(.buttonInactive)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Information"
        view.backgroundColor = .background
        
        setupLeftNavButton()
        
        view.addSubview(horizontalStack)
        view.addSubview(addButton)
        addButton.button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        [pulseField, hrvField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        setupConstraints()
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
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pulseField.heightAnchor.constraint(equalToConstant: 52),
            hrvField.heightAnchor.constraint(equalToConstant: 52),
            
            horizontalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 24),
            horizontalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    // MARK: - Actions
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard
            let pulseText = pulseField.text, let pulse = Int(pulseText), (1..<200).contains(pulse),
            let hrvText = hrvField.text, let hrv = Int(hrvText), (1..<200).contains(hrv)
        else {
            addButton.setStyle(.buttonInactive)
            return
        }

        addButton.setStyle(.buttonActive)
    }

    @objc private func handleAdd() {
        guard
            let pulseText = pulseField.text, let pulse = Int(pulseText),
            let hrvText = hrvField.text, let hrv = Int(hrvText)
        else { return }

        let entry = PulseEntry(pulse: pulse, hrv: hrv)
        onAddEntry?(entry)
        navigationController?.popViewController(animated: true)
    }
}

#Preview {
    LogVC()
}
