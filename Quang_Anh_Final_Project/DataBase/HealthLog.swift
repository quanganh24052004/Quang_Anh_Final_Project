//
//  HealthLog.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/12/25.
//

import Foundation
import RealmSwift
import UIKit

final class PulseEntryObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var pulse: Int
    @Persisted var hrv: Int
    @Persisted var createdAt: Date = Date()

    var status: Status {
        if pulse < 60 { return .low }
        else if pulse > 100 { return .warning }
        else { return .good }
    }

    var statusColor: UIColor { status.color }

    convenience init(pulse: Int, hrv: Int, createdAt: Date = Date()) {
        self.init()
        self.pulse = pulse
        self.hrv = hrv
        self.createdAt = createdAt
    }
}

extension PulseEntryObject {
    convenience init(entry: PulseEntry) {
        self.init(pulse: entry.pulse, hrv: entry.hrv)
    }

    var asEntry: PulseEntry {
        PulseEntry(pulse: pulse, hrv: hrv)
    }
}
