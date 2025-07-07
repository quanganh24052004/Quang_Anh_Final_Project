// MARK: - Import
import UIKit

// MARK: - TabToLog
class TabToLog: UIView {
    // MARK: - Public button
    let button: UIButton = {
        let btn = UIButton(type: .system)
        let backgroundImage = UIImage(named: "mainBtn") // Ảnh trong Assets
        btn.setBackgroundImage(backgroundImage, for: .normal)
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    // MARK: - UI Setup
    private func setupLayout() {
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            //button.heightAnchor.constraint(equalTo: button.widthAnchor)
        ])
    }
    // TODO: Có thể thêm animation cho button nếu cần
}

#Preview {
    TabToLog()
}
