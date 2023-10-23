import UIKit

final class CustomSettingsViewCell: UIView {
    enum SettingType {
        case sounds
        case vibration
        case music
    }

    public private(set) var labelTitle: String
    public private(set) var settingType: SettingType
    var isBackgroundSoundOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isBackgroundSoundOn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isBackgroundSoundOn")
        }
    }

    private lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Pally-Medium", size: 24)
        title.textColor = .black
        return title
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "button-selected"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        return button
    }()

    init(labelTitle: String, settingType: SettingType) {
        self.labelTitle = labelTitle
        self.settingType = settingType
        super.init(frame: .zero)
        isBackgroundSoundOn = UserDefaults.standard.bool(forKey: "isBackgroundSoundOn")
        button.addTarget(self, action: #selector(didButtonWasPressed), for: .touchUpInside)
        setTitle()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomSettingsViewCell {
    @objc private func didButtonWasPressed() {
        switch settingType {
        case .music:
            isBackgroundSoundOn.toggle()
            let backgroundImage = isBackgroundSoundOn ? "button-selected" : "button-unselected"
            button.setImage(UIImage(named: backgroundImage), for: .normal)
            UserDefaults.standard.set(isBackgroundSoundOn, forKey: "isBackgroundSoundOn")
        case .sounds:
            print("sounds")
        case .vibration:
            print("vibration")
        }
    }

    private func setTitle() {
        title.text = labelTitle
    }
}

extension CustomSettingsViewCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),

            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func addSubviews() {
        addSubview(title)
        addSubview(button)
    }
}
