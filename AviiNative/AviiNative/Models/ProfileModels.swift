import Foundation
import Combine

struct Profile: Codable, Identifiable, Equatable {
    let id: UUID
    var firstName: String
    var email: String
    var height: Double
    var weight: Double
    var goals: [String]
    let createdAt: Date

    init(
        id: UUID = UUID(),
        firstName: String,
        email: String,
        height: Double,
        weight: Double,
        goals: [String],
        createdAt: Date = Date()
    ) {
        self.id = id
        self.firstName = firstName
        self.email = email
        self.height = height
        self.weight = weight
        self.goals = goals
        self.createdAt = createdAt
    }
}

final class ProfileStore: ObservableObject {
    @Published private(set) var profile: Profile?

    private let storageKey = "avii.profile.data"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let storage: UserDefaults

    init(storage: UserDefaults = .standard, initialProfile: Profile? = nil) {
        self.storage = storage
        if let initialProfile {
            self.profile = initialProfile
        } else {
            load()
        }
    }

    var hasProfile: Bool {
        profile != nil
    }

    func update(with profile: Profile) {
        self.profile = profile
        persist()
    }

    func reset() {
        profile = nil
        storage.removeObject(forKey: storageKey)
    }

    private func load() {
        guard let data = storage.data(forKey: storageKey) else { return }
        if let decoded = try? decoder.decode(Profile.self, from: data) {
            self.profile = decoded
        }
    }

    private func persist() {
        guard let profile else { return }
        if let data = try? encoder.encode(profile) {
            storage.set(data, forKey: storageKey)
        }
    }
}

#if DEBUG
extension ProfileStore {
    static var preview: ProfileStore {
        let suiteName = "avii.preview.profile"
        let defaults = UserDefaults(suiteName: suiteName) ?? .standard
        defaults.removePersistentDomain(forName: suiteName)
        let sample = Profile(firstName: "Nova", email: "nova@example.com", height: 175, weight: 72, goals: ["Mobility", "Recovery"])
        return ProfileStore(storage: defaults, initialProfile: sample)
    }
}
#endif
