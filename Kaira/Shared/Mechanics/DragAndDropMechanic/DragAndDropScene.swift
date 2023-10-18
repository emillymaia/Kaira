import SpriteKit

class DragAndDropScene: SKScene, SKPhysicsContactDelegate {

    var gamePhaseModel: GamePhaseModel?

    weak var customDelegate: DataDelegate?

    var didPressButton: (() -> Void)?

    var lockScreenInteraction: Bool?

    var currentNode: SKNode?

    var lastZPos = 1

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
        createBackground()
        setupBottomBar()
        setupButtons()
        setupSprites(assets: gamePhaseModel!.assets)
    }

}

extension DragAndDropScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            if !(touchedNodes.first?.name == "background") &&
                !(lockScreenInteraction!) &&
                !(touchedNodes.first?.name == "pause") &&
                !(touchedNodes.first?.name == "setup")
            {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                touchedNodes.first?.zPosition = CGFloat(lastZPos)
                self.currentNode = touchedNodes.first
            }

            if touchedNodes.first?.name == "pause" && !lockScreenInteraction! {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                lockScreenInteraction = true
                addChild(customPopUp)
            }
        }
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

            // rever dps
            scene?.enumerateChildNodes(withName: "background", using: { node, _ in
                let intersectPositionX: Bool =
                (self.currentNode?.position.x)! >= (node.frame.minX) &&
                (self.currentNode?.position.x)! <= (node.frame.maxX) ?
                true : false
                let intersectPositionY: Bool =
                (self.currentNode?.position.y)! >= (node.frame.minY) &&
                (self.currentNode?.position.y)! <= (node.frame.maxY) ?
                true : false

                if intersectPositionX && intersectPositionY {
                    self.currentNode?.name = "setup"
                    self.currentNode?.position = CGPoint(x: (node.position.x), y: (node.position.y))
                }
            })
        }
        self.currentNode = nil
    }

    private func pressButton() {
        didPressButton?()
    }
}

extension DragAndDropScene {

    func setupBottomBar() {
        let bottomNode = SKSpriteNode(imageNamed: (gamePhaseModel?.assets[0])!)
        bottomNode.size = CGSize(width: viewWidth-(viewWidth/8), height: viewHeight/7)
        bottomNode.position = CGPoint(x: (view?.center.x)!, y: viewHeight/10)
        bottomNode.name = "setup"
        addChild(bottomNode)
    }

    func createBackground() {

        let image = UIImage(named: gamePhaseModel!.background)

        let backgroundTexture = SKTexture(image: image!)

        let positionArray = [200, 250, 450, 650]

        for index in 0 ... 2 {

            let background = SKSpriteNode(texture: backgroundTexture)
            background.name = "background"
            background.size = CGSize(
                width: ((view?.frame.width)!*81.7/100)/2,
                height: ((view?.frame.height)!*59.8/100)/3
            )
            background.position = CGPoint(x: positionArray[0], y: positionArray[index+1])
            background.zPosition = -10
            addChild(background)
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

    func setupSprites(assets: [String]) {

        var filteredAssets = assets

        filteredAssets.removeFirst()
        filteredAssets.removeFirst()

        for index in 1 ... 3 {
            let imageName = filteredAssets[Int.random(in: 0...filteredAssets.count-1)]
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

    private func pauseScreenInteraction() {
        lockScreenInteraction = false
    }
}
