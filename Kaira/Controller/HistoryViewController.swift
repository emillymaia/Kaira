import UIKit

class HistoryViewController: UIViewController {

    private let historyPages: [HistoryPageModel]
    private lazy var historyView: HistoryView = {
        let view = HistoryView()
        view.didPressButton = { [weak self] in
            self?.handleButtonPress()
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
//                navigationController?.dismiss(animated: true)
//                return
            }

            if historyPages[currentPageIndex].button == .end {
                onFinishButtonPressed?()
            }

            nextViewController.navigationItem.setHidesBackButton(true, animated: false)
            navigationController?.pushViewController(nextViewController, animated: false)
        }
    }
}

extension HistoryViewController {
    func setImageAndText() {
        let page = historyPages[currentPageIndex]
        let newImage = UIImage(named: page.image)
//        historyView.text.text = page.text

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
