import SpriteKit

class FindImageScene: SKScene, SKPhysicsContactDelegate {

    var currentNode: SKNode?

    var winnerNode: SKSpriteNode?

    var gamePhaseModel: GamePhaseModel?

    weak var customDelegate: DataDelegate?

    var didPressButton: (() -> Void)?

    var lastZPos = 1

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

    var navController = UIViewController()

    private var viewWidth: CGFloat = 0
    private var viewHeight: CGFloat = 0

    override func didMove(to view: SKView) {
        scene?.backgroundColor = .white
        self.viewWidth = (scene?.size.width)!
        self.viewHeight = (scene?.size.height)!
        lockScreenInteraction = false
        setupBottomBar()
        setupButtons()
        winnerNode = setupWinner()
    }
}

extension FindImageScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            if !(touchedNodes.first?.name == "background") &&
                !(lockScreenInteraction!) && !(touchedNodes.first?.name == "pause") {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                touchedNodes.first?.zPosition = CGFloat(lastZPos)
                self.currentNode = touchedNodes.first
            }

            if touchedNodes.first?.name == "pause" && !lockScreenInteraction! {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                // MARCAR PARA LEMBRAR DPS
                let fAction = SKAction.scale(by: 1.5, duration: 0.1)
                let sAction = SKAction.scale(by: 0.66, duration: 0.1)
                let sequence = SKAction.sequence([sAction, fAction])
                touchedNodes.first?.run(sequence)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.lockScreenInteraction = true
                    self.addChild(self.customPopUp)
                }
            }

            if let currentNode = currentNode {
                if currentNode.name == winnerNode!.name {
                    self.currentNode = nil
                    pressButton()
                }
            }
        }
    }

    private func pressButton() {
        customDelegate?.didUpdateData(data: 1)
        didPressButton?()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
                node.position = touchLocation
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.currentNode != nil {
            lastZPos += 1
        }
        self.currentNode = nil
    }
}

extension FindImageScene {

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

    func setupSprites(assets: [String]) {

        for index in 1 ... 29 {
            let imageName = assets[Int.random(in: 0...assets.count-1)]
            let imageNode = SKSpriteNode(imageNamed: imageName)
            imageNode.size = CGSize(width: viewHeight/9, height: viewHeight/9)
            imageNode.position = CGPoint(
                x: Double.random(in: viewWidth/5...viewWidth-(viewWidth/5)),
                y: Double.random(in: viewHeight/5...viewHeight-(viewHeight/5))
            )
            imageNode.name = "\(String(describing: imageName)) \(index)"
            imageNode.zPosition = 0
            self.addChild(imageNode)
        }
    }

    func setupWinner() -> SKSpriteNode? {

        let winnerImage = gamePhaseModel?.assets[1]
        var filteredImages = gamePhaseModel?.assets

        filteredImages?.removeFirst()
        filteredImages?.removeFirst()

        let winnerSprite = SKSpriteNode(imageNamed: winnerImage!)
        winnerSprite.size = CGSize(width: viewHeight/9, height: viewHeight/9)
        winnerSprite.position = CGPoint(
            x: Double.random(in: viewWidth/5...viewWidth-(viewWidth/5)),
            y: Double.random(in: viewHeight/5...viewHeight-(viewHeight/5))
        )
        winnerSprite.zPosition = -1
        winnerSprite.name = "\(String(describing: winnerImage))"
        addChild(winnerSprite)

        setupSprites(assets: filteredImages!)
        return winnerSprite
    }

    func setupButtons() {

        pauseButton = SKSpriteNode(imageNamed: "pause-button")
        pauseButton!.size = CGSize(width: viewWidth/7, height: viewWidth/7)
        pauseButton?.position = CGPoint(
            x: (view?.frame.width)! - ((view?.frame.width)!)/6,
            y: (view?.frame.height)! - (view?.frame.height)!/8
        )
        pauseButton?.name = "pause"
        addChild(pauseButton!)

        customPopUp.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)!)
        customPopUp.navController = navController
        customPopUp.zPosition = 1000
    }

    private func pauseScreenInteraction() {
        lockScreenInteraction = false
    }
}

extension SKNode {
    func animateClick(_ location: CGPoint) {
        let initialScale: CGFloat = 0.8

        UIView.animate(
            withDuration: 0.1,
            animations: {
                self.nodes(at: location).first?.scene?.view?.transform = CGAffineTransform(
                    scaleX: initialScale,
                    y: initialScale
                )
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.nodes(at: location).first?.scene?.view?.transform = CGAffineTransform.identity
                })
            }
        )
    }
}
