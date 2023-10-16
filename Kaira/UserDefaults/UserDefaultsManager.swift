import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let didUserReceivedOnboardingKey = "didUserReceivedOnboarding"

    private init() {}

    var didUserReceivedOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: didUserReceivedOnboardingKey)
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: didUserReceivedOnboardingKey)
        }
    }
}
