import UIKit

class UnlockedStampView: UIView {
    var didPressButton: (() -> Void)?
    private let width = UIScreen.main.bounds.size.width
    private let height = UIScreen.main.bounds.size.height

    var stampImage: UIImageView = {
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
        button.setTitle(String(localized: "Add to album"), for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Pally-Regular", size: 22)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.layer.borderWidth = 3
        button.contentMode = .scaleAspectFit
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
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        button.animateClick()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.13) {
            self.didPressButton?()
        }
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
    }
}

extension UnlockedStampView {
    func setupConstraints() {
        NSLayoutConstraint.activate([

        stampImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: height * 0.01),
        stampImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.07),
        stampImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(width * 0.05)),
        stampImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(height * 0.4)),

            text.topAnchor.constraint(equalTo: stampImage.bottomAnchor),
            text.leadingAnchor.constraint(equalTo: stampImage.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: stampImage.trailingAnchor),

            button.topAnchor.constraint(equalTo: text.bottomAnchor, constant: height * 0.05),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.25),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(width * 0.25)),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(height * 0.09)),
            button.heightAnchor.constraint(equalToConstant: height * 0.06)
        ])
    }
    func addSubviews() {
        addSubview(stampImage)
        addSubview(text)
        addSubview(button)
    }
}
