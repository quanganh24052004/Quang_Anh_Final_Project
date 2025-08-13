import Foundation
import RealmSwift

// MARK: - RealmUserProfile
class RealmUserProfile: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var weight: Int = 0
    @Persisted var height: Int = 0
    @Persisted var genderIndex: Int = 0
    
    convenience init(firstName: String, lastName: String, weight: Int, height: Int, genderIndex: Int) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.weight = weight
        self.height = height
        self.genderIndex = genderIndex
    }
    
    // Convert to UserProfile model
    func toUserProfile() -> UserProfile {
        return UserProfile(firstName: firstName,
                         lastName: lastName,
                         weight: weight,
                         height: height,
                         genderIndex: genderIndex)
    }
}

// Extension for UserProfile to convert to RealmUserProfile
extension UserProfile {
    func toRealmProfile() -> RealmUserProfile {
        return RealmUserProfile(firstName: firstName,
                              lastName: lastName,
                              weight: weight,
                              height: height,
                              genderIndex: genderIndex)
    }
}

