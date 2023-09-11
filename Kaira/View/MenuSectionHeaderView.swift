import UIKit

final class MenuSectionHeaderView: UICollectionReusableView {
    static let identifier = "MenuSectionHeaderView"

    lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Pally-Bold", size: 31)
        return title
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
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func addSubviews() {
        addSubview(title)
    }
}
