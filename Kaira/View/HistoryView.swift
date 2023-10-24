import UIKit

class HistoryView: UIView {
    var didPressButton: (() -> Void)?
    var didPressSkipButton: (() -> Void)?
    private let width = UIScreen.main.bounds.size.width
    private let height = UIScreen.main.bounds.size.height

    var skipButton: UIButton = {
        let skipButton = UIButton()
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitle("Skip", for: .normal)
        skipButton.titleLabel?.font = UIFont(name: "Pally-Regular", size: 22)
        skipButton.setTitleColor(.black, for: .normal)
        skipButton.titleLabel?.numberOfLines = 0
        skipButton.clipsToBounds = true
        return skipButton
    }()

    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    var text: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Pally-Bold", size: 20)
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()

    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonWasPressed), for: .touchUpInside)

        let atributoSublinhado: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let textoAtribuido = NSAttributedString(string: skipButton.currentTitle ?? "", attributes: atributoSublinhado)
        skipButton.setAttributedTitle(textoAtribuido, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func pressButton() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        didPressButton?()
    }

    @objc private func skipButtonWasPressed() {
        didPressSkipButton?()
    }
}

extension HistoryView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: height * 0.03),
            skipButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.8),
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(width * 0.08)),
            skipButton.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -(height * 0.03)),

            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: height * 0.1),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIScreen.main.bounds.size.width * 0.04),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(width * 0.04)),
            image.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(height * 0.35)),

            text.topAnchor.constraint(equalTo: image.bottomAnchor, constant: height * 0.02),
            text.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: image.trailingAnchor),

            button.topAnchor.constraint(equalTo: image.bottomAnchor, constant: height * 0.2),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.7),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: width * 0.04),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(height * 0.027)),
            button.widthAnchor.constraint(equalToConstant: 64),
            button.heightAnchor.constraint(equalToConstant: 64)
        ])
    }

    func addSubviews() {
        addSubview(image)
        addSubview(skipButton)
        addSubview(text)
        addSubview(button)
    }
}
