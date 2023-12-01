import UIKit
extension MenuViewController {

    func historyPresentation(continent: String, stopPoint: Int) {
        if continent == String(localized: "England") {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            preSetupEngland()
        }
        if continent == String(localized: "France") {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            preSetupFrance()
        }
        if continent == String(localized: "Spain") {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            preSetupSpain()
        }
        if continent == String(localized: "Italy") {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            preSetupItaly()
        }
        if continent == String(localized: "Japan") {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            preSetupJapan()
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
        preSetup(EnglandPhaseStructure.self)
    }
    func preSetupFrance() {
        preSetup(FrancePhaseStructure.self)
    }
    func preSetupSpain() {
        preSetup(SpainPhaseStructure.self)
    }
    func preSetupItaly() {
        preSetup(ItalyPhaseStructure.self)
    }
    func preSetupJapan() {
        preSetup(JapanPhaseStructure.self)
    }
}

extension MenuViewController: DataDelegate {
    func didUpdateData(data: Int) {
        if data == 1 {
            if lastPressed == String(localized: "England") {
                self.continentModel[data-1].countries[data].background = "france-selo"
                menuView.menuCollectionView.reloadData()
                if self.progress < data+1 {
                    self.progress = data+1
                    saveInfo(self.progress)
                }
            }
            if lastPressed == String(localized: "France") {
                self.continentModel[data-1].countries[data+1].background = "spain-selo"
                menuView.menuCollectionView.reloadData()
                if self.progress < data+2 {
                    self.progress = data+2
                    saveInfo(self.progress)
                }
            }
            if lastPressed == String(localized: "Spain") {
                self.continentModel[data-1].countries[data+2].background = "italy-selo"
                menuView.menuCollectionView.reloadData()
                if self.progress < data+3 {
                    self.progress = data+3
                    saveInfo(self.progress)
                }
            }
            if lastPressed == String(localized: "Italy") {
                self.continentModel[data].countries[data-1].background = "japan-selo"
                menuView.menuCollectionView.reloadData()
                if self.progress < data+4 {
                    self.progress = data+4
                    saveInfo(self.progress)
                }
            }
            if lastPressed == String(localized: "Japan") {
                self.continentModel[data].countries[data].background = "coming-soon"
                menuView.menuCollectionView.reloadData()
                if self.progress < data+5 {
                    self.progress = data+5
                    saveInfo(self.progress)
                }
            }
        }

        if data == 2 {
            let initialController = UINavigationController(rootViewController: SettingsViewController())
            initialController.navigationItem.setHidesBackButton(false, animated: false)
            initialController.modalPresentationStyle = .overFullScreen
            initialController.modalTransitionStyle = .crossDissolve
            present(initialController, animated: true)
        }

        if data == 3 {
            let initialController = UINavigationController(rootViewController: SettingsViewController())
            initialController.navigationItem.setHidesBackButton(false, animated: false)
            initialController.modalPresentationStyle = .overFullScreen
            initialController.modalTransitionStyle = .crossDissolve
            present(initialController, animated: true)
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
        print(self.progress)
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
        case 4:
            return italy()
        case 5:
            return japan()
        case 6:
            return japan()
        default:
            return england()
        }
    }

    func england() -> [ContinentModel] {
        [
            ContinentModel(
                name: String(localized: "Europe"),
                countries: [
                    CountryModel(name: String(localized: "England"), background: "england-selo"),
                    CountryModel(name: String(localized: "France"), background: "locked-selo"),
                    CountryModel(name: String(localized: "Spain"), background: "locked-selo"),
                    CountryModel(name: String(localized: "Italy"), background: "locked-selo")
                ]
            ),
            ContinentModel(
                name: String(localized: "Asia"),
                countries: [
                    CountryModel(name: String(localized: "Japan"), background: "locked-selo"),
                    CountryModel(name: String(localized: "China"), background: "coming-soon"),
                    CountryModel(name: String(localized: "South Korea"), background: "coming-soon"),
                    CountryModel(name: String(localized: "India"), background: "coming-soon")
                ]
            )
        ]
    }

    func france() -> [ContinentModel] {
        [
            ContinentModel(
                name: String(localized: "Europe"),
                countries: [
                    CountryModel(name: String(localized: "England"), background: "england-selo"),
                    CountryModel(name: String(localized: "France"), background: "france-selo"),
                    CountryModel(name: String(localized: "Spain"), background: "locked-selo"),
                    CountryModel(name: String(localized: "Italy"), background: "locked-selo")
                ]
            ),
            ContinentModel(
                name: String(localized: "Asia"),
                countries: [
                    CountryModel(name: String(localized: "Japan"), background: "locked-selo"),
                    CountryModel(name: String(localized: "China"), background: "coming-soon"),
                    CountryModel(name: String(localized: "South Korea"), background: "coming-soon"),
                    CountryModel(name: String(localized: "India"), background: "coming-soon")
                ]
            )
        ]
    }

    func spain() -> [ContinentModel] {
        [
            ContinentModel(
                name: String(localized: "Europe"),
                countries: [
                    CountryModel(name: String(localized: "England"), background: "england-selo"),
                    CountryModel(name: String(localized: "France"), background: "france-selo"),
                    CountryModel(name: String(localized: "Spain"), background: "spain-selo"),
                    CountryModel(name: String(localized: "Italy"), background: "locked-selo")
                ]
            ),
            ContinentModel(
                name: String(localized: "Asia"),
                countries: [
                    CountryModel(name: String(localized: "Japan"), background: "locked-selo"),
                    CountryModel(name: String(localized: "China"), background: "coming-soon"),
                    CountryModel(name: String(localized: "South Korea"), background: "coming-soon"),
                    CountryModel(name: String(localized: "India"), background: "coming-soon")
                ]
            )
        ]
    }
    func italy() -> [ContinentModel] {
        [
            ContinentModel(
                name: String(localized: "Europe"),
                countries: [
                    CountryModel(name: String(localized: "England"), background: "england-selo"),
                    CountryModel(name: String(localized: "France"), background: "france-selo"),
                    CountryModel(name: String(localized: "Spain"), background: "spain-selo"),
                    CountryModel(name: String(localized: "Italy"), background: "italy-selo")
                ]
            ),
            ContinentModel(
                name: String(localized: "Asia"),
                countries: [
                    CountryModel(name: String(localized: "Japan"), background: "locked-selo"),
                    CountryModel(name: String(localized: "China"), background: "coming-soon"),
                    CountryModel(name: String(localized: "South Korea"), background: "coming-soon"),
                    CountryModel(name: String(localized: "India"), background: "coming-soon")
                ]
            )
        ]
    }
    func japan() -> [ContinentModel] {
        [
            ContinentModel(
                name: String(localized: "Europe"),
                countries: [
                    CountryModel(name: String(localized: "England"), background: "england-selo"),
                    CountryModel(name: String(localized: "France"), background: "france-selo"),
                    CountryModel(name: String(localized: "Spain"), background: "spain-selo"),
                    CountryModel(name: String(localized: "Italy"), background: "italy-selo")
                ]
            ),
            ContinentModel(
                name: String(localized: "Asia"),
                countries: [
                    CountryModel(name: String(localized: "Japan"), background: "japan-selo"),
                    CountryModel(name: String(localized: "China"), background: "coming-soon"),
                    CountryModel(name: String(localized: "South Korea"), background: "coming-soon"),
                    CountryModel(name: String(localized: "India"), background: "coming-soon")
                ]
            )
        ]
    }
}
