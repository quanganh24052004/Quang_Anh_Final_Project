// MARK: IMPORT
import Foundation
import UIKit

// MARK: ENUM
enum Status: String {
    case good = "Good"
    case low = "Low"
    case warning = "Warning"

    var color: UIColor {
        switch self {
        case .good: return UIColor(named: "good") ?? .good00
        case .low: return UIColor(named: "low") ?? .low00
        case .warning: return UIColor(named: "warning") ?? .warning00
        }
    }
}

// MARK: PULSEENTRY
struct PulseEntry: Codable {
    let pulse: Int
    let hrv: Int
    var status: Status {
        if pulse < 60 { return .low }
        else if pulse > 100 { return .warning }
        else { return .good }
    }
}


