//
//  HealthLogManage.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/12/25.
//

import Foundation
import RealmSwift

enum RealmManager {
    static func realm() throws -> Realm {
        // Có thể tuỳ biến Configuration tại đây (migration, fileURL, ...).
        return try Realm()
    }

    @discardableResult
    static func add(_ entry: PulseEntry) throws -> PulseEntryObject {
        let obj = PulseEntryObject(entry: entry)
        let realm = try realm()
        try realm.write { realm.add(obj) }
        return obj
    }

    static func all() throws -> Results<PulseEntryObject> {
        try realm()
            .objects(PulseEntryObject.self)
            .sorted(byKeyPath: "createdAt", ascending: false)
    }

    static func delete(_ obj: PulseEntryObject) throws {
        let realm = try realm()
        try realm.write { realm.delete(obj) }
    }
}
