import UIKit
extension MenuViewController {

    // GAME SETUP FUNCTIONS
    func historyPresentation(continent: String, stopPoint: Int) {
        if continent == "England" {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            preSetupEngland()
        }
        if continent == "France" {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            preSetupFrance()
        }
    }

    func preSetupEngland() {
        let englandPhase = EnglandPhaseStructure(self)
        let initialController = UINavigationController(rootViewController: englandPhase.historyVC[0])
        initialController.navigationItem.setHidesBackButton(true, animated: false)
        initialController.modalPresentationStyle = .overFullScreen
        initialController.modalTransitionStyle = .crossDissolve
        present(initialController, animated: true)
    }

    func preSetupFrance() {
        let francePhase = FrancePhaseStructure(self)
        let initialController = UINavigationController(rootViewController: francePhase.historyVC[0])
        initialController.navigationItem.setHidesBackButton(true, animated: false)
        initialController.modalPresentationStyle = .overFullScreen
        initialController.modalTransitionStyle = .crossDissolve
        present(initialController, animated: true)
    }
}

extension MenuViewController: DataDelegate {
    func didUpdateData(data: Int) {
        if data == 1 {
            if lastPressed == "England" {
                self.continentModel[0].countries[data].background = "france-selo"
                menuView.menuCollectionView.reloadData()
            }

            if lastPressed == "France" {
                print("Finished Flow")
            }
        }
    }
}

extension UINavigationController {
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}
