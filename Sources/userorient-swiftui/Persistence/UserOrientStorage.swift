import Foundation

/// Simple UserDefaults-backed storage used by the UserOrient SDK.
struct UserOrientStorage {
    private static let userUUIDKey = "user_orient_user_uuid"
    private static let projectIdKey = "user_orient_project_id"

    private static var defaults: UserDefaults {
        .standard
    }

    static func currentProjectId() -> String? {
        defaults.string(forKey: projectIdKey)
    }

    static func cacheProjectId(_ projectId: String) {
        defaults.set(projectId, forKey: projectIdKey)
    }

    static func userUUID() -> String? {
        defaults.string(forKey: userUUIDKey)
    }

    static func cacheUserUUID(_ uuid: String) {
        defaults.set(uuid, forKey: userUUIDKey)
    }

    static func clear() {
        defaults.removeObject(forKey: projectIdKey)
        defaults.removeObject(forKey: userUUIDKey)
    }
}

