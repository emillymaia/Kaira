import UIKit

class UnlockedStampViewController: UIViewController {
    var stampImage: String
    var label: String
    var customDelegate: DataDelegate?
    var onFinishButtonPressed: (() -> Void)?
    private lazy var unlockedStampView: UnlockedStampView = {
        let view = UnlockedStampView()
        view.didPressButton = { [weak self] in
            self?.handleButtonPress()
        }
        return view
    }()

    init(stampImage: String, label: String, onFinishButtonPressed:(() -> Void)?) {
        self.onFinishButtonPressed = onFinishButtonPressed
        self.stampImage = stampImage
        self.label = label
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updatePage()
        view = unlockedStampView
        view.backgroundColor = .white
    }
}

extension UnlockedStampViewController {
    private func updatePage() {
//        setImageAndText()
        unlockedStampView.stampImage.image = UIImage(named: stampImage)
        unlockedStampView.text.text = label
    }

    private func handleButtonPress() {
        onFinishButtonPressed?()
        navigationController?.dismiss(animated: true)
    }
}

extension UnlockedStampViewController {
    func setImageAndText() {
        let newImage = UIImage(named: stampImage)

        UIView.transition(
            with: unlockedStampView.stampImage,
            duration: 0.8,
            options: .transitionCrossDissolve,
            animations: {
                self.unlockedStampView.stampImage.image = newImage
            },
            completion: nil
        )
        UIView.transition(
            with: unlockedStampView.text,
            duration: 0.8,
            options: .transitionCrossDissolve,
            animations: {
                self.unlockedStampView.text.text = self.label
            },
            completion: nil
        )
    }
}
