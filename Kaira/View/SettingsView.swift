import UIKit

final class SettingsView: UIView {
    private lazy var musicBackgroundSetting = CustomSettingsViewCell(labelTitle: "Music", settingType: .music)
    private lazy var soundBackgroundSetting = CustomSettingsViewCell(labelTitle: "Music", settingType: .music)
    private lazy var vibrationBackgroundSetting = CustomSettingsViewCell(labelTitle: "Vibration", settingType: .vibration)

    private lazy var star: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "icon-star")
        
        return image
    }()

    private lazy var rateUsTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Pally-Regular", size: 35)
        title.text = "Rate Us!"
        title.textColor = .black
        return title
    }()

    private lazy var TermsLink: UIButton = {
        let link = UIButton()
        link.translatesAutoresizingMaskIntoConstraints = false
        link.setTitle("Terms of Service", for: .normal)
        link.titleLabel?.font = UIFont(name: "Pally-Regular", size: 20)
        link.titleLabel?.textColor = .gray
        link.setTitleColor(.gray, for: .normal)
        link.titleLabel?.numberOfLines = 0
        return link
    }()

    private lazy var PolicyLink: UIButton = {
        let link = UIButton()
        link.translatesAutoresizingMaskIntoConstraints = false
        link.setTitle("Privacy Policy", for: .normal)
        link.titleLabel?.font = UIFont(name: "Pally-Regular", size: 20)
        link.titleLabel?.textColor = .gray
        link.setTitleColor(.gray, for: .normal)
        link.titleLabel?.numberOfLines = 0
        return link
    }()
}
