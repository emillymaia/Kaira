import UIKit
import SpriteKit
// swiftlint: disable all
final class MenuViewController: UIViewController {
    
    let menuView = MenuView()
    var taPassandoDados = 0
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
        return continents[section].countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionCellView.identifier, for: indexPath) as? MenuCollectionCellView else {
            return UICollectionViewCell()
        }
        
        let continent = continents[indexPath.section]
        let country = continent.countries[indexPath.row]
        
        cell.configureCard(country: country.name, withImage: country.background)
        return cell
    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if taPassandoDados == 0 {
            chapter1IntroView.navigationItem.setHidesBackButton(true, animated: false)
            navigationController?.pushViewController(chapter1IntroView, animated: true)
        }
        if taPassandoDados == 2 {
        }
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return continents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MenuSectionHeaderView.identifier, for: indexPath) as? MenuSectionHeaderView else {
                return UICollectionReusableView()
            }
            let continentName = continents[indexPath.section].name
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

    }
}
