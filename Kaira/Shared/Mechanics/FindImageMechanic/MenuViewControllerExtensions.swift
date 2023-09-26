import UIKit
extension MenuViewController {

    // GAME SETUP FUNCTIONS
    func historyPresentation(continent: String, stopPoint: Int) {
        if continent == "Inglaterra" {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            preSetup()

            if taPassandoDados == 0 {
                let initialController = UINavigationController(rootViewController: history0)
                initialController.navigationItem.setHidesBackButton(true, animated: false)
                initialController.modalPresentationStyle = .fullScreen
                present(initialController, animated: true)
            }
        }
        if continent == "França" {
            print("DO NOTHING")
        }
    }

    func preSetup() {
        mech1.gamePhaseModel = gamePhases[0]
        mech2.gamePhaseModel = gamePhases[1]
        mech1.historyViewController = history1
        mech2.historyViewController = history2
        mech1.customDelegate = self
        mech2.customDelegate = self
    }
}
