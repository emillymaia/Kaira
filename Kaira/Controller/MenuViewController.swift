import UIKit
import SpriteKit
// swiftlint: disable all
final class MenuViewController: UIViewController {
    
    let menuView = MenuView()
    var progress = 1
    var lastPressed = ""
    var continentModel: [ContinentModel] = [
        ContinentModel(
            name: String(localized: "Europe"),
            countries: [
                CountryModel(name: String(localized: "England"), background: "england-selo"),
                CountryModel(name: String(localized: "France"), background: "locked-selo"),
                CountryModel(name: String(localized: "Spain"), background: "locked-selo"),
                CountryModel(name: String(localized: "Italy"), background: "coming-soon")
            ]
        ),
        ContinentModel(
            name: String(localized: "Asia"),
            countries: [
                CountryModel(name: String(localized: "Japan"), background: "coming-soon"),
                CountryModel(name: String(localized: "China"), background: "coming-soon"),
                CountryModel(name: String(localized: "South Korea"), background: "coming-soon"),
                CountryModel(name: String(localized: "India"), background: "coming-soon")
            ]
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfo()
        view = menuView
        menuView.menuCollectionView.delegate = self
        menuView.menuCollectionView.dataSource = self
        view.backgroundColor = .white
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

        if cell.background == "coming-soon" || cell.background == "locked-selo" {
            haptic()
            if let comingSoonCell = collectionView.cellForItem(at: indexPath) {
                comingSoonCell.shake()
            }
        } else {
            self.lastPressed = cell.name
            if let selectedCell = collectionView.cellForItem(at: indexPath) {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                selectedCell.animateClick()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                self.historyPresentation(continent: cell.name, stopPoint: 0)
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
            if indexPath.section == 0 {
                guard let subHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SubMenuSectionHeaderView.identifier, for: indexPath) as? SubMenuSectionHeaderView else {
                    return UICollectionReusableView()
                }
                let continentName = continentModel[indexPath.section].name
                subHeader.title.text = continentName
                subHeader.title.textAlignment = .center
                subHeader.customDelegate = self
                return subHeader
            }
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
        return CGSize(width: collectionView.frame.width, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 75, left: 39, bottom: 48, right: 39)
        }

        return UIEdgeInsets(top: 25, left: 39, bottom: 48, right: 39)
    }
}
