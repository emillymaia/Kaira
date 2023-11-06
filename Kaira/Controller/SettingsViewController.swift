import UIKit

final class SettingsViewController: UIViewController {

//    private let settingsView = SettingsView()
    private lazy var settingsView: SettingsView = {
        let view = SettingsView()
        view.didPressTermsButton = { [weak self] in
            self?.handleTermsButtonPressed()
        }
        view.didPressPrivacyButton = { [weak self] in
            self?.handlePrivacyButtonPressed()
        }
        view.didPressRateUsButton = { [weak self] in
            self?.handleRateUsButtonPressed()
        }

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = settingsView
        view.backgroundColor = .white
    }

    private func handleTermsButtonPressed() {
        let alert = UIAlertController(
            title: "Redirecionamento",
            message: "Você será redirecionado para o Safari. Deseja continuar?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Abrir", style: .default, handler: { _ in
            if let url = URL(string: "https://github.com/emillymaia/Kaira/blob/main/privacy.md") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }))
        present(alert, animated: true, completion: nil)
}

    private func handlePrivacyButtonPressed() {
        let alert = UIAlertController(
            title: "Redirecionamento",
            message: "Você será redirecionado para o Safari. Deseja continuar?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Abrir", style: .default, handler: { _ in
            if let url = URL(string: "https://github.com/emillymaia/Kaira/blob/main/privacy.md") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }))
        present(alert, animated: true, completion: nil)
}

    private func handleRateUsButtonPressed() {
        let alert = UIAlertController(
            title: "Redirecionamento",
            message: "Você será redirecionado para o Safari. Deseja continuar?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Abrir", style: .default, handler: { _ in
            if let url = URL(string: "https://forms.gle/xCj7jcndbaiy1VJF7") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}
