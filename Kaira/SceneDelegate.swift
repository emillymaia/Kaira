import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController: UIViewController

        if UserDefaultsManager.shared.didUserReceivedOnboarding == true {
            viewController = HomeScreenViewController()
        } else {
            let intro = IntroPhaseStructure()
            viewController = intro.historyVC[0]
            UserDefaultsManager.shared.isBackgroundSoundOn = true
        }
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}
