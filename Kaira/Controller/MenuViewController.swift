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
                CountryModel(name: "Spain", background: "locked-selo"),
                CountryModel(name: "Italy", background: "locked-selo")
            ]
        ),
        ContinentModel(
            name: "Asia",
            countries: [
                CountryModel(name: "Japan", background: "locked-selo"),
                CountryModel(name: "China", background: "locked-selo"),
                CountryModel(name: "South Korea", background: "locked-selo"),
                CountryModel(name: "India", background: "locked-selo")
            ]
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = menuView
        menuView.menuCollectionView.delegate = self
        menuView.menuCollectionView.dataSource = self
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
        if continentModel[indexPath.section].countries[indexPath.row].background != "locked-selo" {
            self.lastPressed = continentModel[indexPath.section].countries[indexPath.row].name
            historyPresentation(continent: continentModel[indexPath.section].countries[indexPath.row].name, stopPoint: 0)
        } else {
            haptic()
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
