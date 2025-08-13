//
//  RealmManager.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/13/25.
//

import Foundation
import RealmSwift

class RealmUserManager {
    private init() {}
    static let shared = RealmUserManager()
    
    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    // MARK: - User Profile Operations
    func saveUserProfile(_ profile: UserProfile) {
        let realmProfile = profile.toRealmProfile()
        
        do {
            try realm.write {
                // Delete existing profile if any
                if let existingProfile = realm.objects(RealmUserProfile.self).first {
                    realm.delete(existingProfile)
                }
                realm.add(realmProfile)
            }
        } catch {
            print("Error saving user profile: \(error)")
        }
    }
    
    func getUserProfile() -> UserProfile? {
        guard let realmProfile = realm.objects(RealmUserProfile.self).first else {
            return nil
        }
        return realmProfile.toUserProfile()
    }
    
    func deleteUserProfile() {
        do {
            try realm.write {
                let profiles = realm.objects(RealmUserProfile.self)
                realm.delete(profiles)
            }
        } catch {
            print("Error deleting user profile: \(error)")
        }
    }
    
    func hasUserProfile() -> Bool {
        return !realm.objects(RealmUserProfile.self).isEmpty
    }
}
