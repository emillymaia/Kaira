import UIKit
import SpriteKit

final class MenuView: UIView {
    private let configurationsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let stampsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 130, height: 222)
        return layout
    }()

    var menuCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.alwaysBounceVertical = true
        collection.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCollectionViewCell")
        collection.register(MenuSectionHeaderView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: MenuSectionHeaderView.identifier)
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        menuCollectionView.collectionViewLayout = collectionViewLayout
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: topAnchor),
            menuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func addSubviews() {
        addSubview(configurationsButton)
        addSubview(stampsButton)
        addSubview(menuCollectionView)
    }
}
