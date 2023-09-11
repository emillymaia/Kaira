import UIKit

final class MenuCollectionViewCell: UICollectionViewCell {

    static let identifier = "MenuCollectionViewCell"

    var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    var card: UIImageView = {
        let card = UIImageView()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(title)
        contentView.addSubview(card)
        contentView.backgroundColor = .systemBackground
        setupConstraints()
    }
}

extension MenuCollectionViewCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),

            card.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor),
            card.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension MenuCollectionViewCell {
    func configureCard(country: String, withImage named: String) {
        title.text = country
        card.image = UIImage(named: named)
    }
}
