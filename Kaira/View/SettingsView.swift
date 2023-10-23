import UIKit

// swiftlint: disable all
final class SettingsView: UIView {
    var didPressTermsButton: (() -> Void)?
    var didPressPrivacyButton: (() -> Void)?
    var didPressRateUsButton: (() -> Void)?



    private lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Pally-Bold", size: 35)
        title.text = "Settings"
        title.textColor = .black
        return title
    }()

    private lazy var musicBackgroundSetting = CustomSettingsViewCell(labelTitle: "Sounds", settingType: .sounds)
    private lazy var soundBackgroundSetting = CustomSettingsViewCell(labelTitle: "Music", settingType: .music)
    private lazy var vibrationBackgroundSetting = CustomSettingsViewCell(labelTitle: "Vibration", settingType: .vibration)

    private lazy var star: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "icon-star")
        
        return image
    }()

    private lazy var rateUsTitle: UIButton = {
        let title = UIButton()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.setTitle("Rate Us!", for: .normal)
        title.titleLabel?.font = UIFont(name: "Pally-Regular", size: 35)
        title.setTitleColor(.black, for: .normal)
        title.titleLabel?.textColor = .black
        title.titleLabel?.numberOfLines = 0
        return title
    }()

    private lazy var termsLink: UIButton = {
        let link = UIButton()
        link.translatesAutoresizingMaskIntoConstraints = false
        link.setTitle("Terms of Service", for: .normal)
        link.titleLabel?.font = UIFont(name: "Pally-Regular", size: 16)
        link.titleLabel?.textColor = .gray
        link.setTitleColor(.gray, for: .normal)
        link.titleLabel?.numberOfLines = 0
        return link
    }()

    private lazy var policyLink: UIButton = {
        let link = UIButton()
        link.translatesAutoresizingMaskIntoConstraints = false
        link.setTitle("Privacy Policy", for: .normal)
        link.titleLabel?.font = UIFont(name: "Pally-Regular", size: 16)
        link.titleLabel?.textColor = .gray
        link.setTitleColor(.gray, for: .normal)
        link.titleLabel?.numberOfLines = 0
        return link
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        musicBackgroundSetting.translatesAutoresizingMaskIntoConstraints = false
        soundBackgroundSetting.translatesAutoresizingMaskIntoConstraints = false
        vibrationBackgroundSetting.translatesAutoresizingMaskIntoConstraints = false

        addSubviews()
        setupConstraints()

        policyLink.addTarget(self, action: #selector(didSelectPrivacy), for: .touchUpInside)
        termsLink.addTarget(self, action: #selector(didSelectTerms), for: .touchUpInside)
        rateUsTitle.addTarget(self, action: #selector(didSelectRateUs), for: .touchUpInside)

        let atributoSublinhado: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let textoAtribuido = NSAttributedString(string: policyLink.currentTitle ?? "", attributes: atributoSublinhado)
        policyLink.setAttributedTitle(textoAtribuido, for: .normal)

        let atributoSublinhado2: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let textoAtribuido2 = NSAttributedString(string: termsLink.currentTitle ?? "", attributes: atributoSublinhado2)
        termsLink.setAttributedTitle(textoAtribuido2, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView {
    @objc private func didSelectTerms() {
        didPressTermsButton?()
    }

    @objc private func didSelectPrivacy() {
        didPressPrivacyButton?()
    }

    @objc private func didSelectRateUs() {
        didPressRateUsButton?()
    }
}

extension SettingsView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: FrameConstants.screenWidth * 0.33),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(FrameConstants.screenWidth * 0.33)),

            musicBackgroundSetting.topAnchor.constraint(equalTo: title.bottomAnchor, constant: FrameConstants.screenHeight * 0.04),
            musicBackgroundSetting.leadingAnchor.constraint(equalTo: leadingAnchor, constant: FrameConstants.screenWidth * 0.1),
            musicBackgroundSetting.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(FrameConstants.screenWidth * 0.15)),

            soundBackgroundSetting.topAnchor.constraint(equalTo: musicBackgroundSetting.bottomAnchor, constant: FrameConstants.screenHeight * 0.034),
            soundBackgroundSetting.leadingAnchor.constraint(equalTo: leadingAnchor, constant: FrameConstants.screenWidth * 0.1),
            soundBackgroundSetting.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(FrameConstants.screenWidth * 0.15)),

            vibrationBackgroundSetting.topAnchor.constraint(equalTo: soundBackgroundSetting.bottomAnchor, constant: FrameConstants.screenHeight * 0.034),
            vibrationBackgroundSetting.leadingAnchor.constraint(equalTo: leadingAnchor, constant: FrameConstants.screenWidth * 0.1),
            vibrationBackgroundSetting.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(FrameConstants.screenWidth * 0.15)),

            star.topAnchor.constraint(equalTo: vibrationBackgroundSetting.bottomAnchor, constant: FrameConstants.screenHeight * 0.036),
            star.leadingAnchor.constraint(equalTo: leadingAnchor, constant: FrameConstants.screenWidth * 0.3),
            star.trailingAnchor.constraint(equalTo: rateUsTitle.leadingAnchor, constant: -(FrameConstants.screenWidth * 0.02)),

            rateUsTitle.topAnchor.constraint(equalTo: vibrationBackgroundSetting.bottomAnchor, constant: FrameConstants.screenHeight * 0.02),
            rateUsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(FrameConstants.screenWidth * 0.3)),

            termsLink.topAnchor.constraint(equalTo: rateUsTitle.bottomAnchor, constant: FrameConstants.screenHeight * 0.02),
            termsLink.leadingAnchor.constraint(equalTo: leadingAnchor, constant: FrameConstants.screenWidth * 0.35),
            termsLink.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(FrameConstants.screenWidth * 0.35)),

            policyLink.topAnchor.constraint(equalTo: termsLink.bottomAnchor, constant: FrameConstants.screenHeight * 0.02),
            policyLink.leadingAnchor.constraint(equalTo: leadingAnchor, constant: FrameConstants.screenWidth * 0.37),
            policyLink.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(FrameConstants.screenWidth * 0.37)),
            
        ])
    }

    private func addSubviews() {
        addSubview(title)
        addSubview(musicBackgroundSetting)
        addSubview(soundBackgroundSetting)
        addSubview(vibrationBackgroundSetting)
        addSubview(rateUsTitle)
        addSubview(star)
        addSubview(termsLink)
        addSubview(policyLink)
    }
}
