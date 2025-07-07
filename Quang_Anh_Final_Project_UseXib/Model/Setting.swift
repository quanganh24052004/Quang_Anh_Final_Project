// MARK: - Import
import Foundation
import UIKit

// MARK: - SettingItem
struct SettingItem {
    let icon: UIImage?
    let title: String
    let action: (() -> Void)?
    // TODO: Có thể mở rộng thêm các thuộc tính cho SettingItem
}

// MARK: - SettingSection
struct SettingSection {
    let items: [SettingItem]
    // TODO: Có thể thêm header/footer cho section nếu cần
}

