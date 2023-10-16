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
                saveInfo()
            }

            if lastPressed == "France" {
                print("Finished Flow")
                saveInfo()
            }
        }
    }
}

extension UINavigationController {
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.7
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}

extension MenuViewController {
    func loadInfo() {
        if let data = UserDefaults.standard.data(forKey: "continents") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let notes = try decoder.decode([ContinentModel].self, from: data)
                continentModel = notes
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }

    func saveInfo() {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(continentModel)
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "continents")

        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
}
