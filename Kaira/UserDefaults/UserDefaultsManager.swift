import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let didUserReceivedOnboardingKey = "didUserReceivedOnboarding"
    private let isBackgroundSoundOnKey = "isBackgroundSoundOn"
    private let isSoundOnKey = "isSoundOn"

    private init() {
     
    }

    var didUserReceivedOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: didUserReceivedOnboardingKey)
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: didUserReceivedOnboardingKey)
        }
    }

    var isBackgroundSoundOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isBackgroundSoundOnKey)
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: isBackgroundSoundOnKey)
        }
    }

    var isSoundOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isSoundOnKey)
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: isSoundOnKey)
        }
    }
}
