import UIKit

class HistoryView: UIView {
    var didPressButton: (() -> Void)?

    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    var text: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Pally-Regular", size: 17)
        title.numberOfLines = 0
        return title
    }()

    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setupConstraints()
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func pressButton() {
        didPressButton?()
    }

}

extension HistoryView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),

            text.topAnchor.constraint(equalTo: image.bottomAnchor),
            text.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: image.trailingAnchor),

            button.topAnchor.constraint(equalTo: text.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48)
        ])
    }

    func addSubviews() {
        addSubview(image)
        addSubview(text)
        addSubview(button)
    }
}
