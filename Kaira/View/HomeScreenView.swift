import UIKit

final class HomeScreenView: UIView {
    var didPressPlayButton: (() -> Void)?
    var didPressFeedbackButton: (() -> Void)?
    private let width = UIScreen.main.bounds.size.width
    private let height = UIScreen.main.bounds.size.height

    private let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints  = false
        title.text = "Kaira"
        title.font = UIFont(name: "Pally-Regular", size: 120)
        title.textColor = .black
        title.textAlignment = .center
        return title
    }()

    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Pally-Regular", size: 22)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.layer.borderWidth = 3
        button.contentMode = .scaleAspectFit
        return button
    }()

    private let kairaImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "icon-kaira")
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let feedbackLink: UIButton = {
        let link = UIButton()
        link.translatesAutoresizingMaskIntoConstraints = false
        link.setTitle("Give a feedback!", for: .normal)
        link.titleLabel?.font = UIFont(name: "Pally-Regular", size: 20)
        link.titleLabel?.textColor = .gray
        link.setTitleColor(.gray, for: .normal)
        link.titleLabel?.numberOfLines = 0
        return link
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()

        playButton.addTarget(self, action: #selector(playButtonWasPressed), for: .touchUpInside)
        feedbackLink.addTarget(self, action: #selector(feedbackButtonWasPressed), for: .touchUpInside)

        let atributoSublinhado: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let textoAtribuido = NSAttributedString(string: feedbackLink.currentTitle ?? "", attributes: atributoSublinhado)
        feedbackLink.setAttributedTitle(textoAtribuido, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeScreenView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: height * 0.05),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.115),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(width * 0.115)),

            playButton.topAnchor.constraint(equalTo: title.bottomAnchor, constant: height * 0.15),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.074),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(width * 0.63)),

            feedbackLink.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: height *  0.012),
            feedbackLink.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.01),
            feedbackLink.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(width * 0.5)),

            kairaImage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: height * 0.04),
            kairaImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.021),
            kairaImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: width * 0.2)
        ])
    }

    private func addSubviews() {
        addSubview(title)
        addSubview(playButton)
        addSubview(kairaImage)
        addSubview(feedbackLink)
    }
}

extension HomeScreenView {
    @objc private func playButtonWasPressed() {
        didPressPlayButton?()
    }

    @objc private func feedbackButtonWasPressed() {
        didPressFeedbackButton?()
    }
}
