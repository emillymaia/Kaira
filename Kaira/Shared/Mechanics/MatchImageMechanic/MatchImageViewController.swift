import UIKit
import SpriteKit

class MatchImageViewController: UIViewController {
    var skView: SKView!
    var customDelegate: DataDelegate?
    var gamePhaseModel: GamePhaseModel?
    var historyPagesModel: [HistoryPageModel]?
    var historyViewController: HistoryViewController?
    var onFinishButtonPressed: (() -> Void)?

    private lazy var historyGameScene: MatchImageScene = {
        let scene = MatchImageScene(size: skView.bounds.size)
        scene.didPressButton = { [weak self] in
            self?.handleButtonPress()
        }
        return scene
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        skView = SKView(frame: view.frame)
        skView.showsFPS = false
        skView.showsNodeCount = false
        view.addSubview(skView)

        historyGameScene.gamePhaseModel = gamePhaseModel
        historyGameScene.customDelegate = customDelegate
        historyGameScene.navController = self

        skView.presentScene(historyGameScene)
    }

    private func handleButtonPress() {

        historyViewController!.navigationItem.setHidesBackButton(true, animated: false)
        historyViewController?.customDelegate = customDelegate
        navigationController?.fadeTo(historyViewController!)
    }
}
