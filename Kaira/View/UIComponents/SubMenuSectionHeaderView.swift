import UIKit

final class SubMenuSectionHeaderView: UICollectionReusableView {
    static let identifier = "SubMenuSectionHeaderView"
    var customDelegate: DataDelegate?

    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.isBaselineRelativeArrangement = true
        stack.distribution = .equalSpacing
        return stack
    }()

    var configurationsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "config"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.imageView?.image?.withRenderingMode(.alwaysOriginal)
        button.frame.size = CGSize(width: 60, height: 60)
        return button
    }()

    var stampsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "album"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.imageView?.image?.withRenderingMode(.alwaysOriginal)
        button.frame.size = CGSize(width: 60, height: 60)
        return button
    }()

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
        configurationsButton.addTarget(
            self,
            action: #selector(didConfigButtonWasPressed),
            for: [.touchUpInside, .touchUpOutside]
        )
        stampsButton.addTarget(
            self,
            action: #selector(didAlbumButtonWasPressed),
            for: [.touchUpInside, .touchUpOutside]
        )
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        addSubviews()
//        setupConstraints()
    }
}

extension SubMenuSectionHeaderView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stampsButton.topAnchor.constraint(equalTo: topAnchor),
            stampsButton.heightAnchor.constraint(equalToConstant: 50),
            stampsButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 45),
            stampsButton.widthAnchor.constraint(equalToConstant: 50),

            configurationsButton.topAnchor.constraint(equalTo: topAnchor),
            configurationsButton.heightAnchor.constraint(equalToConstant: 50),
            configurationsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            configurationsButton.widthAnchor.constraint(equalToConstant: 50),
            horizontalStack.topAnchor.constraint(equalTo: stampsButton.bottomAnchor, constant: 15),

            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            horizontalStack.heightAnchor.constraint(equalToConstant: 30),

            title.centerXAnchor.constraint(equalTo: horizontalStack.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: horizontalStack.centerYAnchor),

            rectangle2.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 20),
            rectangle2.trailingAnchor.constraint(equalTo: horizontalStack.trailingAnchor)
        ])
    }

    private func addSubviews() {
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(rectangle)
        horizontalStack.addArrangedSubview(title)
        horizontalStack.addArrangedSubview(rectangle2)
        addSubview(configurationsButton)
        addSubview(stampsButton)
        bringSubviewToFront(stampsButton)
        bringSubviewToFront(configurationsButton)

    }
}

extension SubMenuSectionHeaderView {

    @objc private func didConfigButtonWasPressed() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        configurationsButton.animateClick()
        customDelegate?.didUpdateData(data: 2)
    }

    @objc private func didAlbumButtonWasPressed() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        stampsButton.animateClick()
        customDelegate?.didUpdateData(data: 3)
    }

}
