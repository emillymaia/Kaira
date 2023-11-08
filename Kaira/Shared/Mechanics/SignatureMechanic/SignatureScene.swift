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

    var navController = UIViewController()

    private var viewWidth: CGFloat = 0
    private var viewHeight: CGFloat = 0

    override func didMove(to view: SKView) {
        scene?.backgroundColor = .white
        self.viewWidth = (scene?.size.width)!
        self.viewHeight = (scene?.size.height)!
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
            if touchedNodes.first?.name == "done" {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                pressButton()
            }

            if touchedNodes.first?.name == "pause" && !(lockScreenInteraction!) {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                // MARCAR PARA LEMBRAR DPS
                let fAction = SKAction.scale(by: 1.5, duration: 0.1)
                let sAction = SKAction.scale(by: 0.66, duration: 0.1)
                let sequence = SKAction.sequence([fAction, sAction])
                touchedNodes.first?.run(sequence)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.lockScreenInteraction = true
                    self.canvasView.drawingPolicy = .pencilOnly
                    self.canvasView.layer.position = CGPoint(x: 1000, y: 1000)
                    self.addChild(self.customPopUp)
                }
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
        if viewHeight < 700 {
            bottomNode.size = CGSize(width: viewWidth-(viewWidth/4), height: viewHeight/8)
            bottomNode.position = CGPoint(x: (view?.center.x)!, y: viewHeight/8)
        } else {
            bottomNode.size = CGSize(width: viewWidth-(viewWidth/4), height: viewHeight/10)
            bottomNode.position = CGPoint(x: (view?.center.x)!, y: viewHeight/8)
        }
        bottomNode.name = "background"

        addChild(bottomNode)
    }

    func createBackground() {

        let image = UIImage(named: gamePhaseModel!.background)

        let backgroundTexture = SKTexture(image: image!)

        for _ in 0 ... 1 {

            let background = SKSpriteNode(texture: backgroundTexture)
            background.name = "background"

            if viewHeight < 700 {
                background.size = CGSize(
                    width: ((view?.frame.width)!*0.79),
                    height: ((view?.frame.height)!*0.62)
                )
                background.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)! + viewHeight/53)
            } else {
                background.size = CGSize(
                    width: ((view?.frame.width)!*0.81),
                    height: ((view?.frame.height)!*0.59)
                )
                background.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)! + viewHeight/40)
            }

            background.zPosition = -10
            addChild(background)

            canvasView.frame = CGRect(
                x: ((view?.frame.width)! - background.frame.width)/2,
                y: (((view?.frame.height)! - background.frame.height)/1.8 - background.frame.height/14),
                width: background.size.width,
                height: background.size.height - background.size.height/7
            )
            canvasView.layer.zPosition = 10
            canvasView.isOpaque = false
            view!.addSubview(canvasView)

            let doneButton = SKSpriteNode(imageNamed: "game-done-button")

            if viewHeight < 700 {
                doneButton.size = CGSize(width: viewWidth/3.5, height: viewHeight/13)
                doneButton.position = CGPoint(
                    x: (view?.center.x)!,
                    y: ((view?.center.y)!) - background.size.height/2.5
                )
            } else {
                doneButton.size = CGSize(width: viewWidth/3, height: viewHeight/15)
                doneButton.position = CGPoint(
                    x: (view?.center.x)!,
                    y: ((view?.center.y)!) - background.size.height/2.5
                )
            }
            doneButton.zPosition = 40
            doneButton.name = "done"

            addChild(doneButton)
        }
    }

    func setupButtons() {

        pauseButton = SKSpriteNode(imageNamed: "pause-button")
        pauseButton!.size = CGSize(width: viewWidth/7, height: viewWidth/7)
        pauseButton?.position = CGPoint(
            x: (view?.frame.width)! - ((view?.frame.width)!)/6,
            y: (view?.frame.height)! - (view?.frame.height)!/8
        )
        pauseButton?.zPosition = 900
        pauseButton?.name = "pause"
        addChild(pauseButton!)

        customPopUp.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)!)
        customPopUp.navController = navController
        customPopUp.zPosition = 1000
    }

    private func pauseScreenInteraction() {
        lockScreenInteraction = false
        canvasView.drawingPolicy = .anyInput
        canvasView.layer.position = CGPoint(
            x: (view?.center.x)!,
            y: (view?.center.y)! - (view?.frame.height)!/12
        )
    }
}
