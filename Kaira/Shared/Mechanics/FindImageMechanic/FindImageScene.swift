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

    override func didMove(to view: SKView) {
        scene?.backgroundColor = .white
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
                lockScreenInteraction = true
                addChild(customPopUp)
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
        if gamePhaseModel?.countryName == "England" {
            customDelegate?.didUpdateData(data: 1)
        }
        didPressButton?()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)

            if !(
                touchLocation.x < (view?.frame.minX)!+node.frame.width/2
                || touchLocation.x > 343
                || touchLocation.y < 220
                || touchLocation.y > 750
            ) {
                    node.position = touchLocation
            }
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
        bottomNode.size = CGSize(width: 355, height: 120)
        bottomNode.position = CGPoint(x: (view?.center.x)!, y: 120)
        bottomNode.name = "background"

        addChild(bottomNode)
    }

    func setupSprites(assets: [String]) {
        for index in 1 ... 12 {
            let imageName = assets[Int.random(in: 0...assets.count-1)]
            let imageNode = SKSpriteNode(imageNamed: imageName)
            imageNode.size = CGSize(width: 100, height: 100)
            imageNode.position = CGPoint(x: Double.random(in: 49...343), y: Double.random(in: 220...750))
            imageNode.name = "\(String(describing: imageName)) \(index)"
            imageNode.zPosition = 0
            imageNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
            imageNode.physicsBody?.affectedByGravity = false
            imageNode.physicsBody?.isDynamic = false
            self.addChild(imageNode)
        }
    }

    func setupWinner() -> SKSpriteNode? {
        let winnerImage = gamePhaseModel?.assets[1]
        var filteredImages = gamePhaseModel?.assets

        filteredImages?.removeFirst()
        filteredImages?.removeFirst()

        let winnerSprite = SKSpriteNode(imageNamed: winnerImage!)
        winnerSprite.size = CGSize(width: 100, height: 100)
        winnerSprite.position = CGPoint(x: Double.random(in: 49...343), y: Double.random(in: 200...650))
        winnerSprite.zPosition = -1
        winnerSprite.name = "\(String(describing: winnerImage))"
        winnerSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
        winnerSprite.physicsBody?.affectedByGravity = false
        winnerSprite.physicsBody?.isDynamic = false
        addChild(winnerSprite)

        setupSprites(assets: filteredImages!)
        return winnerSprite
    }

    func setupButtons() {
        pauseButton = SKSpriteNode(imageNamed: "pause-button")
        pauseButton!.size = CGSize(width: 50, height: 50)
        pauseButton?.position = CGPoint(
            x: (view?.frame.width)! - ((view?.frame.width)!)/8,
            y: (view?.frame.height)! - (view?.frame.height)!/10
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
