import SpriteKit
import PencilKit

class SignatureScene: SKScene, SKPhysicsContactDelegate {

    var gamePhaseModel: GamePhaseModel?

    weak var customDelegate: DataDelegate?

    var didPressButton: (() -> Void)?

    var lockScreenInteraction: Bool?

    private var pauseButton: SKSpriteNode?

    private lazy var customPopUp: CustomPopup = {
        let view = CustomPopup()
        view.size = CGSize(width: 250, height: 260)
        view.didClose = { [weak self] in
            self?.pauseScreenInteraction()
        }
        return view
    }()

    let canvasView: PKCanvasView = {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput
        canvas.drawing = PKDrawing()
        return canvas
    }()

    override func didMove(to view: SKView) {
        scene?.backgroundColor = .white
        lockScreenInteraction = false
        createBackground()
        setupBottomBar()
        setupButtons()
    }

}

extension SignatureScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            print(touchedNodes.first?.name)
            if touchedNodes.first?.name == "done" {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                pressButton()
            }

            if touchedNodes.first?.name == "pause" && !(lockScreenInteraction!) {
                lockScreenInteraction = true
                canvasView.drawingPolicy = .pencilOnly
                canvasView.frame = CGRect(
                    x: 1000,
                    y: 1000)
                addChild(customPopUp)
            }
        }
    }

    private func pressButton() {
        clearDrawing()
        didPressButton?()
    }
}

extension SignatureScene {

    func clearDrawing() {
        self.canvasView.drawing = PKDrawing()
    }

    func setupBottomBar() {
        let bottomNode = SKSpriteNode(imageNamed: (gamePhaseModel?.assets[0])!)
        bottomNode.size = CGSize(width: 355, height: 120)
        bottomNode.position = CGPoint(x: (view?.center.x)!, y: 120)
        bottomNode.name = "background"
        bottomNode.zPosition = 1

        addChild(bottomNode)
    }

    func createBackground() {

        let image = UIImage(named: gamePhaseModel!.background)

        let backgroundTexture = SKTexture(image: image!)

        for _ in 0 ... 1 {

            let background = SKSpriteNode(texture: backgroundTexture)
            background.name = "background"
            background.size = CGSize(
                width: ((view?.frame.width)!*81.7/100),
                height: ((view?.frame.height)!*59.8/100)
            )
            background.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)! + 40)
            background.zPosition = -10
            addChild(background)

            canvasView.frame = CGRect(
                x: ((view?.frame.width)! - background.frame.width)/2,
                y: (((view?.frame.height)! - background.frame.height)/2 - background.frame.height/14),
                width: background.size.width,
                height: background.size.height - background.size.height/7
            )
            canvasView.layer.zPosition = 10
            canvasView.isOpaque = false
            view!.addSubview(canvasView)

            let doneButton = SKSpriteNode(imageNamed: "game-done-button")
            doneButton.size = CGSize(width: 107, height: 50)
            doneButton.position = CGPoint(
                x: (view?.center.x)!,
                y: ((view?.center.y)!) - background.size.height/3
            )
            doneButton.zPosition = 40
            doneButton.name = "done"

            addChild(doneButton)
        }
    }

    func setupButtons() {
        pauseButton = SKSpriteNode(imageNamed: "pause-button")
        pauseButton!.size = CGSize(width: 50, height: 50)
        pauseButton?.position = CGPoint(
            x: (view?.frame.width)! - ((view?.frame.width)!)/8,
            y: (view?.frame.height)! - (view?.frame.height)!/10
        )
        pauseButton?.zPosition = 900
        pauseButton?.name = "pause"
        addChild(pauseButton!)

        customPopUp.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)!)
        customPopUp.zPosition = 1000
    }

    private func pauseScreenInteraction() {
        lockScreenInteraction = false
        canvasView.frame = CGRect(
            x: ((view?.frame.width)! - background.frame.width)/2,
            y: (((view?.frame.height)! - background.frame.height)/2 - background.frame.height/14)
        )
        canvasView.drawingPolicy = .anyInput
    }
}
