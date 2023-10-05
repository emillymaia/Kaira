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

    private func updatePage() {
        let page = historyPages[currentPageIndex]
        historyView.image.image = UIImage(named: page.image)
        historyView.text.text = page.text
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
        } else {
            let nextViewController = historyPages[currentPageIndex].nextViewController ?? UIViewController()

            if historyPages[currentPageIndex].button == .finish {
                onFinishButtonPressed?()
                navigationController?.dismiss(animated: true)
                return
            }

            if historyPages[currentPageIndex].button == .end {
                onFinishButtonPressed?()
            }

            nextViewController.navigationItem.setHidesBackButton(true, animated: false)
            navigationController?.pushViewController(nextViewController, animated: false)
        }
    }
}
