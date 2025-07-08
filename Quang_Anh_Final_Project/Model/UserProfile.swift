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
    private static let key = "user_profile"
    
    static func save(_ profile: UserProfile) {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    static func get() -> UserProfile? {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode(UserProfile.self, from: data) else {
            return nil
        }
        return decoded
    }
    
    static func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }

    static func hasProfile() -> Bool {
        return get() != nil
    }
}
