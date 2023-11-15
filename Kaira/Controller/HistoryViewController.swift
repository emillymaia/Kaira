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
        if let sound = page.audio {
            setSound(sound)
        }

        if page.button == .finish {
            let image = resizeImage(image: UIImage(named: "Start")!, targetSize: CGSize(width: 64, height: 64))
            historyView.button.setImage(image, for: .normal)
        } else {
            let image = resizeImage(image: UIImage(named: "NextPage")!, targetSize: CGSize(width: 64, height: 64))
            historyView.button.setImage(image, for: .normal)
        }
    }

    private func handleButtonPress() {
        if currentPageIndex < historyPages.count - 1 {
            SoundManager.shared.stopBackgroundMusic()
            currentPageIndex += 1
            updatePage()
        } else {
            let nextViewController = self.historyPages[self.currentPageIndex].nextViewController
            ?? UIViewController()
            SoundManager.shared.stopBackgroundMusic()
            if self.historyPages[self.currentPageIndex].button == .finish {
                self.onFinishButtonPressed?()
            }
            if self.historyPages[self.currentPageIndex].button == .end {
                self.onFinishButtonPressed?()
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

    func setSound(_ sound: String) {
        SoundManager.shared.playEffectSound(sound)
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(
                width: size.width * heightRatio,
                height: size.height * heightRatio
            )
        } else {
            newSize = CGSize(
                width: size.width * widthRatio,
                height: size.height * widthRatio
            )
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
