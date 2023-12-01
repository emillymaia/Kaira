import UIKit

final class MenuSectionHeaderView: UICollectionReusableView {
    static let identifier = "MenuSectionHeaderView"

    lazy var rectangle: UIImageView = {
        let rectangle = UIImageView()
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        rectangle.image = UIImage(named: "divider")
        rectangle.contentMode = .scaleAspectFit
        return rectangle
    }()

    lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Pally-Bold", size: 31)
        title.numberOfLines = 0
        return title
    }()

    lazy var rectangle2: UIImageView = {
        let rectangle = UIImageView()
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        rectangle.image = UIImage(named: "divider")
        rectangle.contentMode = .scaleAspectFit
        return rectangle
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setupConstraints()
    }
}

extension MenuSectionHeaderView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rectangle.topAnchor.constraint(equalTo: topAnchor),
            rectangle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            rectangle.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -20),
            rectangle.bottomAnchor.constraint(equalTo: bottomAnchor),

            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),

            rectangle2.topAnchor.constraint(equalTo: topAnchor),
            rectangle2.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 20),
            rectangle2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            rectangle2.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func addSubviews() {
        addSubview(title)
        addSubview(rectangle)
        addSubview(rectangle2)
    }
}
