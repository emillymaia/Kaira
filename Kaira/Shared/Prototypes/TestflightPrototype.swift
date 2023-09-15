import SpriteKit

class Challenge: SKScene, SKPhysicsContactDelegate {

    weak var menuViewController: UIViewController?

    var currentNode: SKNode?

    var winnerNode: SKSpriteNode?

    weak var customDelegate: DataDelegate?

    var setter: Int?

    var sprites: [SKSpriteNode] = []

    var imageNames: [String] = ["tic-1", "tic-2", "tic-3", "tic-4", "tic-5"]

    let topBorder = SKSpriteNode()
    let leftBorder = SKSpriteNode()
    let rightBorder = SKSpriteNode()
    let bottomBorder = SKSpriteNode()

    var lastZPos = 1

    override func didMove(to view: SKView) {
        createBackground()
        setupBorders()
        setupBottomBar()
        winnerNode = setupWinner()
        if winnerNode == nil {
            return
        }
        setupSprites()
    }
}

extension Challenge {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            if !(touchedNodes.first?.name == "background") {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                touchedNodes.first?.zPosition = CGFloat(lastZPos)
                self.currentNode = touchedNodes.first
            }
            if currentNode == winnerNode {
                print("Win")
                if let setter = setter {
                    if (setter == 0) {
                        customDelegate?.didUpdateData(data: 1)
                    }
                    if (setter == 1) {
                        customDelegate?.didUpdateData(data: 2)
                    }
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
//            node.position = touchLocation

            if !(touchLocation.x < (view?.frame.minX)!+node.frame.width/2 || touchLocation.x > 343 || touchLocation.y < 220 || touchLocation.y > 750) {
//            if !(touchLocation.y < 220 || touchLocation.y > 750) {
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


extension Challenge {

    func setupBottomBar() {
        let bottomNode = SKSpriteNode(imageNamed: "bord")
        bottomNode.size = CGSize(width: (view?.frame.width)!, height: 120)
        bottomNode.position = CGPoint(x: (view?.center.x)!, y: 60)
        bottomNode.name = "background"

        addChild(bottomNode)

        let bottomNodeE = SKSpriteNode(imageNamed: "elip")
        bottomNodeE.size = CGSize(width: 120, height: 120)
        bottomNodeE.position = CGPoint(x: (view?.center.x)!, y: 120)
        bottomNodeE.name = "background"

        addChild(bottomNodeE)
    }

    func setupSprites() {
        for index in 1 ... 10 {
            let imageName = imageNames[Int.random(in: 0...imageNames.count-1)]
            let imageNode = SKSpriteNode(imageNamed: imageName)
            imageNode.size = CGSize(width: 80, height: 80)
            imageNode.position = CGPoint(x: Double.random(in: 49...343), y: Double.random(in: 220...750))
            imageNode.name = "\(imageName) \(index)"
            imageNode.zPosition = 0
            imageNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
            imageNode.physicsBody?.affectedByGravity = false
            imageNode.physicsBody?.isDynamic = false
            sprites.append(imageNode)
            self.addChild(imageNode)
        }
    }

    func setupWinner() -> SKSpriteNode? {
        let winnerImage = imageNames[Int.random(in: 0...imageNames.count-1)]
        imageNames.removeAll(where: { $0 == winnerImage })
        print(winnerImage)
        print(imageNames)

        let winnerSprite = SKSpriteNode(imageNamed: winnerImage)
        winnerSprite.size = CGSize(width: 80, height: 80)
        winnerSprite.position = CGPoint(x: Double.random(in: 49...343), y: Double.random(in: 200...650))
        winnerSprite.zPosition = -1
        winnerSprite.name = "\(winnerImage)"
        winnerSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 80))
        winnerSprite.physicsBody?.affectedByGravity = false
        winnerSprite.physicsBody?.isDynamic = false
        self.addChild(winnerSprite)

        let winner = SKSpriteNode(imageNamed: winnerImage)
        winner.position = CGPoint(x: (view?.center.x)!, y: 120)
        winner.name = "background"
        winner.size = CGSize(width: 80, height: 80)
        addChild(winner)
        return winnerSprite
    }

    func setupBorders() {
        self.bottomBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 1))
        self.bottomBorder.physicsBody?.affectedByGravity = false
        self.bottomBorder.physicsBody?.isDynamic = false
        self.bottomBorder.position = .init(x: frame.width/2, y: frame.height/4.5)
        self.bottomBorder.name = "wall"

        addChild(self.bottomBorder)

        self.topBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 1))
        self.topBorder.physicsBody?.affectedByGravity = false
        self.topBorder.physicsBody?.isDynamic = false
        self.topBorder.position = .init(x: frame.width/2, y: frame.height)
        self.topBorder.name = "wall"

        addChild(self.topBorder)

        self.leftBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        self.leftBorder.physicsBody?.affectedByGravity = false
        self.leftBorder.physicsBody?.isDynamic = false
        self.leftBorder.position = .init(x: 0, y: frame.height/2)
        self.leftBorder.name = "wall"

        addChild(self.leftBorder)

        self.rightBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        self.rightBorder.physicsBody?.affectedByGravity = false
        self.rightBorder.physicsBody?.isDynamic = false
        self.rightBorder.position = .init(x: frame.width, y: frame.height/2)
        self.rightBorder.name = "wall"

        addChild(self.rightBorder)
    }

    func createBackground() {

        let image = UIImage(named: "background-test")
        let scaledImage = image?.scalePreservingAspectRatio(
            targetSize: CGSize(
                width: (view?.frame.width)!*2,
                height: (view?.frame.height)!*2
            )
        )

        let backgroundTexture = SKTexture(image: scaledImage!)

        for _ in 0 ... 1 {

            let background = SKSpriteNode(texture: backgroundTexture)
            background.name = "background"
            background.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)!)
            background.zPosition = -10
            addChild(background)

//            let moveLeft = SKAction.moveBy(x: 0, y: backgroundTexture.size().height/10, duration: 30)
//            let moveReset = SKAction.moveBy(x: 0, y: -backgroundTexture.size().height/10, duration: 0)
//            let moveLoop = SKAction.sequence([moveLeft, moveReset])
//            let moveForever = SKAction.repeatForever(moveLoop)
//
//            background.run(moveForever)
        }
    }
}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        let scaleFactor = min(widthRatio, heightRatio)

        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }

        return scaledImage
    }
}

