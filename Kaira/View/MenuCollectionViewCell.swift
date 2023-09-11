import UIKit

final class MenuCollectionViewCell: UICollectionViewCell {

    static let identifier = "MenuCollectionViewCell"

    var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Pally-Regular", size: 22)
        return title
    }()

    var card: UIImageView = {
        let card = UIImageView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        card.layer.borderWidth = 3
        card.layer.cornerRadius = 25
        card.layer.masksToBounds = true
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

            card.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
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
