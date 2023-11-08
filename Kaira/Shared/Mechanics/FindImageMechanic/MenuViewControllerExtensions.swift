import UIKit
extension MenuViewController {

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

    func preSetup<T: PhaseStructure>(_ phase: T.Type) {
        let phase = T.init(self)
        let initialController = UINavigationController(rootViewController: phase.historyVC[0])
        initialController.navigationItem.setHidesBackButton(true, animated: false)
        initialController.modalPresentationStyle = .overFullScreen
        initialController.modalTransitionStyle = .crossDissolve
        present(initialController, animated: true)
    }

    func preSetupEngland() {
        preSetup(TestPhaseStructure.self)
    }

    func preSetupFrance() {
        preSetup(FrancePhaseStructure.self)
    }
    func preSetupSpain() {
        preSetup(SpainPhaseStructure.self)
    }
}

extension MenuViewController: DataDelegate {
    func didUpdateData(data: Int) {
        if data == 1 {
            if lastPressed == "England" {
                self.continentModel[0].countries[data].background = "france-selo"
                menuView.menuCollectionView.reloadData()
                if self.progress < data+1 {
                    self.progress = data+1
                    saveInfo(self.progress)
                }
            }
            if lastPressed == "France" {
                self.continentModel[0].countries[data+1].background = "spain-selo"
                menuView.menuCollectionView.reloadData()
                if self.progress < data+2 {
                    self.progress = data+2
                    saveInfo(self.progress)
                }
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
        self.progress = data
        continentModel = setupFirst(self.progress)
    }

    func saveInfo(_ value: Int) {
        UserDefaults.standard.set(value, forKey: "progress")
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
