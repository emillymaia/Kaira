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
        initialController.modalPresentationStyle = .fullScreen
        present(initialController, animated: false)
    }

    func preSetupFrance() {
        let francePhase = FrancePhaseStructure(self)
        let initialController = UINavigationController(rootViewController: francePhase.historyVC[0])
        initialController.navigationItem.setHidesBackButton(true, animated: false)
        initialController.modalPresentationStyle = .fullScreen
        present(initialController, animated: false)
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
