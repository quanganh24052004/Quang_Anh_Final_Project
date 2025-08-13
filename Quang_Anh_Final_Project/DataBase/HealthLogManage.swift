import Foundation
import RealmSwift

enum PulseLogRealmManager {
    static func realm() throws -> Realm {
        return try Realm()
    }

    @discardableResult
    static func add(_ entry: PulseEntry) throws -> PulseEntryObject {
        let obj = PulseEntryObject(entry: entry)
        let realm = try realm()
        try realm.write {
            realm.add(obj)
        }
        return obj
    }

    static func all() throws -> Results<PulseEntryObject> {
        try realm()
            .objects(PulseEntryObject.self)
            .sorted(byKeyPath: "createdAt", ascending: false)
    }

    static func delete(_ obj: PulseEntryObject) throws {
        let realm = try realm()
        try realm.write {
            realm.delete(obj)
        }
    }
    
    // Ví dụ: filter by date range
    static func entries(from: Date, to: Date) throws -> Results<PulseEntryObject> {
        try realm()
            .objects(PulseEntryObject.self)
            .filter("createdAt >= %@ AND createdAt <= %@", from, to)
            .sorted(byKeyPath: "createdAt", ascending: false)
    }
}
