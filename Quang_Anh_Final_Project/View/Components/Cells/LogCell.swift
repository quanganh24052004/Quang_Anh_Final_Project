// MARK: - Import
import UIKit

// MARK: - LogCell
class LogCell: UICollectionViewCell {
    static let identifier = "LogCell"
    
    // MARK: - Subviews
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "heartIcon")
        imgView.tintColor = .buttonActive
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let pulseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .labelCell
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pulseValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelCell
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hrvLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .labelCell
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hrvValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelCell
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .labelCell
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelCell
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        contentView.layer.cornerRadius = 12
        //contentView.layer.borderWidth = 1
        //contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = .white
        
        [imgView, pulseLabel, pulseValueLabel, hrvLabel, hrvValueLabel, statusLabel, statusValueLabel].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            // Pulse
            pulseLabel.topAnchor.constraint(equalTo: imgView.topAnchor),
            pulseLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 12),
            pulseLabel.widthAnchor.constraint(equalToConstant: 80),
            pulseValueLabel.bottomAnchor.constraint(equalTo: imgView.bottomAnchor),
            pulseValueLabel.leadingAnchor.constraint(equalTo: pulseLabel.leadingAnchor),
            // HRV
            hrvLabel.topAnchor.constraint(equalTo: imgView.topAnchor),
            hrvLabel.leadingAnchor.constraint(equalTo: pulseLabel.trailingAnchor, constant: 12),
            hrvLabel.widthAnchor.constraint(equalToConstant: 80),
            hrvValueLabel.bottomAnchor.constraint(equalTo: imgView.bottomAnchor),
            hrvValueLabel.leadingAnchor.constraint(equalTo: hrvLabel.leadingAnchor),
            // Status
            statusLabel.topAnchor.constraint(equalTo: imgView.topAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: hrvLabel.trailingAnchor, constant: 12),
            statusLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -12),
            statusValueLabel.bottomAnchor.constraint(equalTo: imgView.bottomAnchor),
            statusValueLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor)
        ])
    }

    // MARK: - Public API
    func configure(with entry: PulseEntry) {
        pulseLabel.text = "Pulse:"
        pulseValueLabel.text = "\(entry.pulse) bpm"
        hrvLabel.text = "HRV:"
        hrvValueLabel.text = "\(entry.hrv) ms"
        statusLabel.text = "Status"
        statusValueLabel.text = entry.status.rawValue
        let color = entry.status.color
        pulseValueLabel.textColor = color
        hrvValueLabel.textColor = color
        statusValueLabel.textColor = color
    }
    // TODO: Có thể thêm animation khi cell được chọn hoặc xóa
}

#Preview {
    LogCell()
}
