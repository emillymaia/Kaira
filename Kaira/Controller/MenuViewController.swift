import UIKit
import SpriteKit
// swiftlint: disable all
final class MenuViewController: UIViewController {
    let menuView = MenuView()
    var taPassandoDados = 0
    var gameViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = menuView
        menuView.menuCollectionView.delegate = self
        menuView.menuCollectionView.dataSource = self
        didUpdateData(data: taPassandoDados)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
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
        let scene = Inicio(size: view.bounds.size)
//        scene.scaleMode = .aspectFill
        scene.customDelegate = self
        scene.setter = taPassandoDados
        let skView = SKView(frame: view.frame)
        skView.presentScene(scene)
        gameViewController.view = skView

        if taPassandoDados == 0 {
            gameViewController.view = skView
            gameViewController.modalPresentationStyle = .fullScreen
            present(gameViewController, animated: true)
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
        taPassandoDados = data

        if taPassandoDados == 2 {
            dismiss(animated: true)
            taPassandoDados = 0
        }
    }
}

//extension MenuViewController: DataDelegate {
//    func didUpdateData(data: Int) {
//        taPassandoDados = data
//        print(taPassandoDados)
//    }
//
//    // nao estou mais utilizando
//    func configureSectionHeader(_ section: Int) {
//        let indexPath = IndexPath(item: 0, section: section)
//        let header = menuView.menuCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? MenuSectionHeaderView
//        header?.title.text = "\(taPassandoDados)"
//    }
//}
