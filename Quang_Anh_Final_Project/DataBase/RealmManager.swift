import Foundation
import RealmSwift

class RealmUserManager {
    private init() {}
    static let shared = RealmUserManager()
    
    // Cache Realm instance (chỉ dùng trên main thread)
    private lazy var realm: Realm = {
        do {
            return try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }()
    
    // MARK: - User Profile Operations
    
    @discardableResult
    func saveUserProfile(_ profile: UserProfile) -> Bool {
        let realmProfile = profile.toRealmProfile()
        do {
            try realm.write {
                if let existingProfile = realm.objects(RealmUserProfile.self).first {
                    realm.delete(existingProfile)
                }
                realm.add(realmProfile)
            }
            return true
        } catch {
            print("Error saving user profile: \(error)")
            return false
        }
    }
    
    func getUserProfile() -> UserProfile? {
        guard let realmProfile = realm.objects(RealmUserProfile.self).first else {
            return nil
        }
        return realmProfile.toUserProfile()
    }
    
    @discardableResult
    func deleteUserProfile() -> Bool {
        do {
            try realm.write {
                let profiles = realm.objects(RealmUserProfile.self)
                realm.delete(profiles)
            }
            return true
        } catch {
            print("Error deleting user profile: \(error)")
            return false
        }
    }
    
    func hasUserProfile() -> Bool {
        return !realm.objects(RealmUserProfile.self).isEmpty
    }
}
