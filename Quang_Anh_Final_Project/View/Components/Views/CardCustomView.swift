import UIKit

class CardCustomView: UIView {
    // MARK: - View Setup
    private let checkBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = .boxCard
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let checkIconView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isHidden = true
        return img
    }()

    private let imageLabel: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18, weight: .regular)
        lbl.textColor = .text
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    var isSelectedCard: Bool = false {
        didSet {
            if isSelectedCard {
                checkIconView.image = UIImage(systemName: "checkmark.square.fill")
                checkIconView.tintColor = UIColor.buttonActive
                checkIconView.isHidden = false

                checkBoxView.backgroundColor = .white

                self.layer.borderColor = UIColor.buttonActive.cgColor
                self.layer.borderWidth = 2
            } else {
                checkIconView.isHidden = true

                checkBoxView.backgroundColor = .boxCard  // hoặc màu nền mặc định

                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 0
            }
        }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(){
        backgroundColor = .systemBackground
        layer.cornerRadius = 20

        addSubview(checkBoxView)
        checkBoxView.addSubview(checkIconView)
        addSubview(imageLabel)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            // CheckBoxView
            checkBoxView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            checkBoxView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            checkBoxView.widthAnchor.constraint(equalToConstant: 24),
            checkBoxView.heightAnchor.constraint(equalToConstant: 24),

            // CheckIconView fits inside CheckBoxView
            checkIconView.topAnchor.constraint(equalTo: checkBoxView.topAnchor),
            checkIconView.bottomAnchor.constraint(equalTo: checkBoxView.bottomAnchor),
            checkIconView.leadingAnchor.constraint(equalTo: checkBoxView.leadingAnchor),
            checkIconView.trailingAnchor.constraint(equalTo: checkBoxView.trailingAnchor),

            imageLabel.topAnchor.constraint(equalTo: checkBoxView.bottomAnchor, constant: 8),
            imageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageLabel.widthAnchor.constraint(equalToConstant: 64),
            imageLabel.heightAnchor.constraint(equalTo: imageLabel.widthAnchor), // keep 1:1 ratio

            titleLabel.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Public API
    func configure(with option: CardOption) {
        imageLabel.image = UIImage(named: option.imageName)
        titleLabel.text = option.title
    }
}

