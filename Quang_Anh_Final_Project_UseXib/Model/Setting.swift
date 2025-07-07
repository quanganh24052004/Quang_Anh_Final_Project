import Foundation
import UIKit

struct SettingItem {
    let icon: UIImage?
    let title: String
    let action: (() -> Void)?
}

struct SettingSection {
    let items: [SettingItem]
}

