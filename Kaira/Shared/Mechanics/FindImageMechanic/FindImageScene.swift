import SpriteKit

class FindImageScene: SKScene, SKPhysicsContactDelegate {

    var currentNode: SKNode?

    var winnerNode: SKSpriteNode?

    var gamePhaseModel: GamePhaseModel?

    weak var customDelegate: DataDelegate?

    var didPressButton: (() -> Void)?

    var lastZPos = 1

    override func didMove(to view: SKView) {
        scene?.backgroundColor = .white
        createBackground()
        setupBottomBar()
        winnerNode = setupWinner()
    }
}

extension FindImageScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            if !(touchedNodes.first?.name == "background") {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                touchedNodes.first?.zPosition = CGFloat(lastZPos)
                self.currentNode = touchedNodes.first
            }
            if let currentNode = currentNode {
                if currentNode.name == winnerNode!.name {
                    print("winner")
                    self.currentNode = nil
                    pressButton()
                }
            }
        }
    }

    private func pressButton() {
        print("pressed")
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

    override func update(_ currentTime: TimeInterval) {

    }
}

extension FindImageScene {

    func setupBottomBar() {
        let bottomNode = SKSpriteNode(imageNamed: "objective-1")
        bottomNode.size = CGSize(width: 355, height: 120)
        bottomNode.position = CGPoint(x: (view?.center.x)!, y: 120)
        bottomNode.name = "background"

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

    func setupSprites(assets: [String]) {
        for index in 1 ... 5 {
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
        let winnerImage = "tic-2"
        let filteredImages = (gamePhaseModel?.assets.filter({ $0 != winnerImage }))!

        let winnerSprite = SKSpriteNode(imageNamed: winnerImage)
        winnerSprite.size = CGSize(width: 100, height: 100)
        winnerSprite.position = CGPoint(x: Double.random(in: 49...343), y: Double.random(in: 200...650))
        winnerSprite.zPosition = -1
        winnerSprite.name = "\(String(describing: winnerImage))"
        winnerSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
        winnerSprite.physicsBody?.affectedByGravity = false
        winnerSprite.physicsBody?.isDynamic = false
        addChild(winnerSprite)

        setupSprites(assets: filteredImages)
        return winnerSprite
    }

    func createBackground() {

//        let image = UIImage(named: gamePhaseModel!.background)
//        let scaledImage = image?.scalePreservingAspectRatio(
//            targetSize: CGSize(
//                width: (view?.frame.width)!*2,
//                height: (view?.frame.height)!*2
//            )
//        )
//
//        let backgroundTexture = SKTexture(image: scaledImage!)
//
//        for _ in 0 ... 1 {
//
//            let background = SKSpriteNode(texture: backgroundTexture)
//            background.name = "background"
//            background.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)!)
//            background.zPosition = -10
//            addChild(background)
//        }
    }
}
