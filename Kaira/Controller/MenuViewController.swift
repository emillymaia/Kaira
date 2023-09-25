import UIKit
import SpriteKit
// swiftlint: disable all
final class MenuViewController: UIViewController {
    
    let menuView = MenuView()
    var taPassandoDados = 0
    var continentModel: [ContinentModel] = [ContinentModel(name: "Europa", countries: [CountryModel(name: "Inglaterra", background: "Fase1Selo"), CountryModel(name: "França", background: "Fase1Selo")])]
    var gamePhases: [GamePhaseModel] = [GamePhaseModel(countryName: "England", background: "background-test", assets: ["tic-1", "tic-2", "tic-3", "tic-4", "tic-5"])]
//    var gameViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = menuView
        menuView.menuCollectionView.delegate = self
        menuView.menuCollectionView.dataSource = self
    }
}
extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < continents.count else {
            return 0
        }
        return continentModel[section].countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionCellView.identifier, for: indexPath) as? MenuCollectionCellView else {
            return UICollectionViewCell()
        }
        
        let continent = continentModel[indexPath.section]
        let country = continent.countries[indexPath.row]
        
        cell.configureCard(country: country.name, withImage: country.background)
        return cell
    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        historyPresentation(continent: continentModel[indexPath.section].countries[indexPath.row].name, stopPoint: 0)
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return continentModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MenuSectionHeaderView.identifier, for: indexPath) as? MenuSectionHeaderView else {
                return UICollectionReusableView()
            }
            let continentName = continentModel[indexPath.section].name
            header.title.text = continentName
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 39, bottom: 48, right: 39)
    }
}

extension MenuViewController: DataDelegate {
    func didUpdateData(data: Int) {
        if data == 2 {
            self.dismiss(animated: true)
        }
    }
}

extension MenuViewController {
    func historyPresentation(continent: String, stopPoint: Int) {
        if continent == "Inglaterra" {
            mech1.gamePhaseModel = gamePhases.first
            mech2.gamePhaseModel = gamePhases.first
            mech3.gamePhaseModel = gamePhases.first
            mech1.historyViewController = history1
            mech2.historyViewController = history2
            mech3.historyViewController = history3
            mech1.customDelegate = self
            mech2.customDelegate = self
            mech3.customDelegate = self


//            let history = [HistoryPageModel(image: "OBJ1", text: textChapter1IntroView, button: .finish, nextViewController: mechanic)]
//
//            let game = HistoryViewController(historyPages: history) {
//                print("foi")
//            }

            if taPassandoDados == 0 {
                mech1.navigationItem.setHidesBackButton(true, animated: false)
                mech1.modalPresentationStyle = .fullScreen
                present(mech1, animated: true)
            }
        }
        if continent == "França" {
            print("DO NOTHING")
        }
    }
}
