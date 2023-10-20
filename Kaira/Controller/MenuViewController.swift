import UIKit
import SpriteKit
// swiftlint: disable all
final class MenuViewController: UIViewController {
    
    let menuView = MenuView()
    var lastPressed = ""
    var continentModel: [ContinentModel] = [
        ContinentModel(
            name: "Europe",
            countries: [
                CountryModel(name: "England", background: "england-selo"),
                CountryModel(name: "France", background: "locked-selo"),
                CountryModel(name: "Spain", background: "coming-soon"),
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
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfo()
        view = menuView
        menuView.menuCollectionView.delegate = self
        menuView.menuCollectionView.dataSource = self

        startMusic()
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < continentModel.count else {
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
        let cell = continentModel[indexPath.section].countries[indexPath.row]

        if cell.background != "locked-selo" {
            self.lastPressed = cell.name
            historyPresentation(continent: cell.name, stopPoint: 0)
        }

        if cell.background == "coming-soon" {
            haptic()
            if let comingSoonCell = collectionView.cellForItem(at: indexPath) {
                comingSoonCell.shake()
            }
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.shake()
            }
        }
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
            header.title.textAlignment = .center
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
