import UIKit

class HistoryViewController: UIViewController {

    private let historyPages: [HistoryPageModel]
    private lazy var historyView: HistoryView = {
        let view = HistoryView()
        view.didPressButton = { [weak self] in
            self?.handleButtonPress()
        }
        view.didPressSkipButton = { [weak self] in
            self?.handleSkipButtonPress()
        }

        return view
    }()
    var currentPageIndex: Int = 0
    var customDelegate: DataDelegate?
    var onFinishButtonPressed: (() -> Void)?

    init(historyPages: [HistoryPageModel], onFinishButtonPressed:(() -> Void)?) {
        self.historyPages = historyPages
        self.onFinishButtonPressed = onFinishButtonPressed
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updatePage()
        view = historyView
        view.backgroundColor = .white
    }
}

extension HistoryViewController {
    private func updatePage() {
        let page = historyPages[currentPageIndex]
        setImageAndText()

        if page.button == .finish {
            historyView.button.setImage(UIImage(named: "Start"), for: .normal)
            customDelegate!.didUpdateData(data: 1)
        } else {
            historyView.button.setImage(UIImage(named: "NextPage"), for: .normal)
        }
    }

    private func handleButtonPress() {
        if currentPageIndex < historyPages.count - 1 {
            currentPageIndex += 1
            updatePage()
            historyView.button.animateClick()
        } else {
            let nextViewController = historyPages[currentPageIndex].nextViewController ?? UIViewController()
            if historyPages[currentPageIndex].button == .finish {
                onFinishButtonPressed?()
            }
            if historyPages[currentPageIndex].button == .end {
                onFinishButtonPressed?()
            }
            nextViewController.navigationItem.setHidesBackButton(true, animated: false)
            self.navigationController?.fadeTo(nextViewController)
        }
    }

    private func handleSkipButtonPress() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        if UserDefaultsManager.shared.didUserReceivedOnboarding == false {
            let viewController = HomeScreenViewController()
            viewController.navigationItem.setHidesBackButton(true, animated: false)
            UserDefaultsManager.shared.didUserReceivedOnboarding = true
            navigationController?.fadeTo(viewController)
        } else {
            let skipViewController = historyPages[currentPageIndex].skipViewController ?? UIViewController()
            skipViewController.navigationItem.setHidesBackButton(true, animated: false)
            self.navigationController?.fadeTo(skipViewController)
        }
    }
}

extension HistoryViewController {
    func setImageAndText() {
        let page = historyPages[currentPageIndex]
        let newImage = UIImage(named: page.image)

        UIView.transition(
            with: historyView.image,
            duration: 0.8,
            options: .transitionCrossDissolve,
            animations: {
                self.historyView.image.image = newImage
            },
            completion: nil
        )
        UIView.transition(
            with: historyView.text,
            duration: 0.8,
            options: .transitionCrossDissolve,
            animations: {
                self.historyView.text.text = page.text
            },
            completion: nil
        )
    }
}
