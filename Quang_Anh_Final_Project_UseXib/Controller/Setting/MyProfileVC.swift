import UIKit

class MyProfileVC: UIViewController {
    
    private let infoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        title = "My Profile"
        setupUI()
        setupDeleteButton()
        loadProfile()
    }
    
    private func setupUI() {
        infoLabel.numberOfLines = 0
        infoLabel.textColor = .label
        infoLabel.font = .systemFont(ofSize: 16)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func loadProfile() {
        guard let profile = ProfileStorage.get() else {
            infoLabel.text = "No Profile Found"
            return
        }

        infoLabel.text = """
        Name: \(profile.firstName) \(profile.lastName)
        Gender: \(profile.genderIndex == 0 ? "Male" : "Female")
        Weight: \(profile.weight)
        Height: \(profile.height)
        """
    }
    private func setupDeleteButton() {
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(confirmDelete))
        navigationItem.rightBarButtonItem = deleteItem
    }

    @objc private func confirmDelete() {
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete your profile?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            ProfileStorage.clear()
            self.showDeletedAlert()
        }))
        
        present(alert, animated: true)
    }

    private func showDeletedAlert() {
        let done = UIAlertController(title: "Deleted", message: "Your profile has been deleted.", preferredStyle: .alert)
        done.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(done, animated: true)
    }
}
