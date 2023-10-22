import UIKit

final class HomeScreenViewController: UIViewController {

    private lazy var homeScreenView: HomeScreenView = {
        let view = HomeScreenView()
        view.didPressPlayButton = { [weak self] in
            self?.handlePlayButtonPressed()
        }
        view.didPressFeedbackButton = { [weak self] in
            self?.handleFeedbackButtonPressed()
        }

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeScreenView
        view.backgroundColor = .white
    }

    private func handlePlayButtonPressed() {
        let controller = MenuViewController()
        controller.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.fadeTo(controller)
    }

    private func handleFeedbackButtonPressed() {
        let alert = UIAlertController(title: "Redirecionamento", message: "Você será redirecionado para o Safari. Deseja continuar?", preferredStyle: .alert)
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
