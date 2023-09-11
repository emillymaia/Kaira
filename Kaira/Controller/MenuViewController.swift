import UIKit
import SpriteKit
// swiftlint: disable all
final class MenuViewController: UIViewController {
    let menuView = MenuView()
    let continents: [ContinentModel] = [
        ContinentModel(name: "Asia", countries: asia),
        ContinentModel(name: "Europa", countries: europa),
        ContinentModel(name: "America", countries: america)
    ]
    var taPassandoDados = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = menuView
        menuView.menuCollectionView.delegate = self
        menuView.menuCollectionView.dataSource = self
        didUpdateData(data: taPassandoDados)
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < continents.count else {
            return 0
        }
        return continents[section].countries.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let continent = continents[indexPath.section]
        let country = continent.countries[indexPath.row]
        
        cell.configureCard(country: country.name, withImage: country.background)
        return cell
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let scene = TesteNavigation(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        scene.customDelegate = self
        let skView = SKView(frame: view.frame)
        skView.presentScene(scene)
        
        let gameViewController = UIViewController()
        gameViewController.view = skView
        
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    func configureSectionHeader(_ section: Int) {
        let indexPath = IndexPath(item: 0, section: section)
        let header = menuView.menuCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? MenuSectionHeaderView
        header?.title.text = "\(taPassandoDados)"
    }
}

extension MenuViewController: DataDelegate {
    func didUpdateData(data: Int) {
        taPassandoDados = data
        print(taPassandoDados)
        //        for section in 0..<continents.count {
        //            configureSectionHeader(section)
        //        }
    }
}
