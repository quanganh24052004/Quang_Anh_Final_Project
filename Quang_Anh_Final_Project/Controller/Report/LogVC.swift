// MARK: - Import
import UIKit

// MARK: - LogVC
class LogVC: UIViewController {
    // MARK: - Properties
    var onAddEntry: ((PulseEntry) -> Void)?

    // MARK: - UI Components
    private let pulseForm = FormCV(title: "Pulse", placeholder: "Enter Pulse")
    private let hrvForm = FormCV(title: "HRV", placeholder: "Enter HRV")

    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let addButton: PrimaryButton = {
        let btn = PrimaryButton()
        btn.setTitle("Add")
        btn.setStyle(.neutral3)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        navigationItem.title = "Information"
        setupLeftNavButton()
        setupUI()
        setupAction()
    }

    // MARK: - UI Setup
    private func setupUI() {
        setupMainStack()
        setupAddButton()
        setupConstraints()
    }
    private func setupMainStack() {
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(pulseForm)
        mainStack.addArrangedSubview(hrvForm)
    }
    private func setupAddButton() {
        view.addSubview(addButton)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pulseForm.heightAnchor.constraint(equalToConstant: 80),
            hrvForm.heightAnchor.constraint(equalToConstant: 80),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    // MARK: - Navigation
    private func setupLeftNavButton() {
        let leftButtonView = LeftNavButton()
        leftButtonView.iconImageView.image = UIImage(systemName: "chevron.left")
        leftButtonView.onTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        let leftItem = UIBarButtonItem(customView: leftButtonView)
        navigationItem.leftBarButtonItem = leftItem
    }

    // MARK: - Actions
    private func setupAction() {
        [pulseForm.textField, hrvForm.textField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }

        addButton.button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
    }

    // MARK: - Validation
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard
            let pulseText = pulseForm.textField.text, let pulse = Int(pulseText), (1..<200).contains(pulse),
            let hrvText = hrvForm.textField.text, let hrv = Int(hrvText), (1..<200).contains(hrv)
        else {
            addButton.setStyle(.neutral3)
            return
        }
        addButton.setStyle(.primary1)
    }

    // MARK: - Handle Add Entry
    @objc private func handleAdd() {
        guard
            let pulseText = pulseForm.textField.text, let pulse = Int(pulseText),
            let hrvText = hrvForm.textField.text, let hrv = Int(hrvText)
        else { return }

        let entry = PulseEntry(pulse: pulse, hrv: hrv)
        var allEntries = PulseEntry.loadAll()
        allEntries.append(entry)
        PulseEntry.saveAll(allEntries)
        onAddEntry?(entry)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Optional: Populate existing entry
    func configure(with entry: PulseEntry) {
        pulseForm.textField.text = "\(entry.pulse)"
        hrvForm.textField.text = "\(entry.hrv)"
    }
}

#Preview {
    LogVC()
}

// MARK: - PulseEntry UserDefaults Extension
extension PulseEntry {
    static let userDefaultsKey = "pulse_entries"
    static func saveAll(_ entries: [PulseEntry]) {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
    static func loadAll() -> [PulseEntry] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let entries = try? JSONDecoder().decode([PulseEntry].self, from: data) else {
            return []
        }
        return entries
    }
    // TODO: Có thể thêm hàm xóa từng entry nếu cần
}
