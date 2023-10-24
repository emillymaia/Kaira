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
        if continent == "Spain" {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            preSetupSpain()
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
    func preSetupSpain() {
        let spainPhase = SpainPhaseStructure(self)
        let initialController = UINavigationController(rootViewController: spainPhase.historyVC[0])
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
                self.progress = data+1
                saveInfo(self.progress)
            }
            if lastPressed == "France" {
                self.continentModel[0].countries[data+1].background = "spain-selo"
                menuView.menuCollectionView.reloadData()
                self.progress = data+2
                saveInfo(self.progress)
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
        let data = UserDefaults.standard.integer(forKey: "progress")
        print(data)
        self.progress = data
        continentModel = setupFirst(self.progress)

//        if let data = UserDefaults.standard.integer(forKey: "progress") {
//            do {
//                // Create JSON Decoder
//                let decoder = JSONDecoder()
//                // Decode Note
//                let notes = try decoder.decode([ContinentModel].self, from: data)
//                continentModel = notes
//            } catch {
//                print("Unable to Decode Notes (\(error))")
//            }
//        }
    }

    func saveInfo(_ value: Int) {
        UserDefaults.standard.set(value, forKey: "progress")
//        do {
//            // Create JSON Encoder
//            let encoder = JSONEncoder()
//
//            // Encode Note
//            let data = try encoder.encode(continentModel)
//            // Write/Set Data
//            UserDefaults.standard.set(data, forKey: "progress")
//
//        } catch {
//            print("Unable to Encode Array of Notes (\(error))")
//        }
    }
}


extension MenuViewController {

    public func setupFirst(_ value: Int) -> [ContinentModel] {
        switch value {
        case 1:
            return england()
        case 2:
            return france()
        case 3:
            return spain()
        default:
            return england()
        }
    }

    func england() -> [ContinentModel] {
        [
            ContinentModel(
                name: "Europe",
                countries: [
                    CountryModel(name: "England", background: "england-selo"),
                    CountryModel(name: "France", background: "locked-selo"),
                    CountryModel(name: "Spain", background: "locked-selo"),
                    CountryModel(name: "Italy", background: "coming-soon")
                ]
            ),
            ContinentModel(
                name: "Asia",
                countries: [
                    CountryModel(name: "Japan", background: "coming-soon"),
                    CountryModel(name: "China", background: "coming-soon"),
                    CountryModel(name: "South Korea", background: "coming-soon"),
                    CountryModel(name: "India", background: "coming-soon")
                ]
            )
        ]
    }

    func france() -> [ContinentModel] {
        [
            ContinentModel(
                name: "Europe",
                countries: [
                    CountryModel(name: "England", background: "england-selo"),
                    CountryModel(name: "France", background: "france-selo"),
                    CountryModel(name: "Spain", background: "locked-selo"),
                    CountryModel(name: "Italy", background: "coming-soon")
                ]
            ),
            ContinentModel(
                name: "Asia",
                countries: [
                    CountryModel(name: "Japan", background: "coming-soon"),
                    CountryModel(name: "China", background: "coming-soon"),
                    CountryModel(name: "South Korea", background: "coming-soon"),
                    CountryModel(name: "India", background: "coming-soon")
                ]
            )
        ]
    }

    func spain() -> [ContinentModel] {
        [
            ContinentModel(
                name: "Europe",
                countries: [
                    CountryModel(name: "England", background: "england-selo"),
                    CountryModel(name: "France", background: "france-selo"),
                    CountryModel(name: "Spain", background: "spain-selo"),
                    CountryModel(name: "Italy", background: "coming-soon")
                ]
            ),
            ContinentModel(
                name: "Asia",
                countries: [
                    CountryModel(name: "Japan", background: "coming-soon"),
                    CountryModel(name: "China", background: "coming-soon"),
                    CountryModel(name: "South Korea", background: "coming-soon"),
                    CountryModel(name: "India", background: "coming-soon")
                ]
            )
        ]
    }
}
