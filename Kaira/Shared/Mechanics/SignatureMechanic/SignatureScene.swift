import SpriteKit
import PencilKit

class SignatureScene: SKScene, SKPhysicsContactDelegate {

    var gamePhaseModel: GamePhaseModel?

    weak var customDelegate: DataDelegate?

    var didPressButton: (() -> Void)?

    let canvasView: PKCanvasView = {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput
        canvas.drawing = PKDrawing()
        return canvas
    }()

    override func didMove(to view: SKView) {
        scene?.backgroundColor = .white
        createBackground()
        setupBottomBar()
    }

}

extension SignatureScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            print(touchedNodes.first?.name)
            if touchedNodes.first?.name == "done" {
                print("winner")
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                pressButton()
            }
        }
    }

    private func pressButton() {
        print("pressed")
        clearDrawing()
        didPressButton?()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    override func update(_ currentTime: TimeInterval) {

    }
}

extension SignatureScene {

    func clearDrawing() {
        self.canvasView.drawing = PKDrawing()
    }

    func setupBottomBar() {
        let bottomNode = SKSpriteNode(imageNamed: "objective-2")
        bottomNode.size = CGSize(width: 355, height: 120)
        bottomNode.position = CGPoint(x: (view?.center.x)!, y: 120)
        bottomNode.name = "background"
        bottomNode.zPosition = 1

        addChild(bottomNode)

        let pauseButton = SKSpriteNode(imageNamed: "pause-button")
        pauseButton.size = CGSize(width: 50, height: 50)
        pauseButton.position = CGPoint(
            x: (view?.frame.width)! - ((view?.frame.width)!)/8,
            y: (view?.frame.height)! - (view?.frame.height)!/10
        )
        pauseButton.name = "background"

        addChild(pauseButton)
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

            let doneButton = SKSpriteNode(imageNamed: "done-button")
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
}
