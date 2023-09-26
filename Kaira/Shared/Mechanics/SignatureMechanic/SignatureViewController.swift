import UIKit
import SpriteKit

class SignatureViewController: UIViewController {
    var skView: SKView!
    var customDelegate: DataDelegate?
    var gamePhaseModel: GamePhaseModel?
    var historyPagesModel: [HistoryPageModel]?
    var historyViewController: HistoryViewController?
    var onFinishButtonPressed: (() -> Void)?

    private lazy var historyGameScene: SignatureScene = {
        let scene = SignatureScene(size: skView.bounds.size)
        scene.didPressButton = { [weak self] in
            self?.handleButtonPress()
        }
        return scene
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Custom Delegate VC: \(String(describing: customDelegate))")

        skView = SKView(frame: view.frame)
        skView.showsFPS = true
        skView.showsNodeCount = true
        view.addSubview(skView)

        historyGameScene.gamePhaseModel = gamePhaseModel
        historyGameScene.customDelegate = customDelegate

        skView.presentScene(historyGameScene)
    }

    private func handleButtonPress() {

        historyViewController!.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.pushViewController(historyViewController!, animated: true)
    }
}
