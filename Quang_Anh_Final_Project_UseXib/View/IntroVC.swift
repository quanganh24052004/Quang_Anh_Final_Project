import UIKit

class IntroVC: UIViewController {

    // MARK: INITIALIZATION

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Health Plan Pro"
        label.textColor = .title
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Providing workout routines and health information to support well-being."
        label.textColor = .subtitle
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let continueButton: PrimaryButton = {
        let btn = PrimaryButton()
        btn.setTitle("Continue")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let imgIntrobw: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_intro_bw")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let imgIntrofr: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_intro_fr")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        // 🖼 Thêm ảnh trước
        view.addSubview(imgIntrobw)
        view.addSubview(imgIntrofr)
        
        // 🏷 Thêm label sau để nằm trên ảnh
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        // 🔘 Thêm button cuối cùng
        view.addSubview(continueButton)
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        setupConstraints()
    }
    
    // MARK: CONSTRAINTS
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),

            // Continue Button
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 50),

            // imgIntrobw
            imgIntrobw.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 86),
            imgIntrobw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            imgIntrobw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -156),
            imgIntrobw.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -68),

            // imgIntrofr
            imgIntrofr.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            imgIntrofr.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 132),
            imgIntrofr.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            imgIntrofr.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -68)
        ])
    }
    
    @objc private func didTapContinue() {
        let nextVC = SelectionVC1()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}


#Preview {
    IntroVC()
}
