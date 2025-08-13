// MARK: IMPORT
import Foundation

// MARK: USERPROFILE
struct UserProfile: Codable {
    let firstName: String
    let lastName: String
    let weight: Int
    let height: Int
    let genderIndex: Int
}

// MARK: PROFILESTORAGE
class ProfileStorage {
    static func save(_ profile: UserProfile) {
        RealmUserManager.shared.saveUserProfile(profile)
    }

    static func get() -> UserProfile? {
        return RealmUserManager.shared.getUserProfile()
    }
    
    static func clear() {
        RealmUserManager.shared.deleteUserProfile()
    }

    static func hasProfile() -> Bool {
        return RealmUserManager.shared.hasUserProfile()
    }
}
