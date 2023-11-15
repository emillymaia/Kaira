import SpriteKit
// swiftlint: disable all

class FlagScene: SKScene, SKPhysicsContactDelegate {

    var gamePhaseModel: GamePhaseModel?

    weak var customDelegate: DataDelegate?

    var didPressButton: (() -> Void)?

    var lockScreenInteraction: Bool?

    var currentNode: SKNode?

    var lastZPos = 1

    var lastXYpos: [CGFloat] = []

    var  XposArray: [CGFloat] = []
    var  YposArray: [CGFloat] = []

    private var pauseButton: SKSpriteNode?

    var backgroundList: [String] = []
    var colorList: Int = 0

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
        viewWidth = (scene?.frame.width)!
        viewHeight = (scene?.frame.height)!
        lockScreenInteraction = false
        setupBottomBar()
        setupButtons()
        setupSprites(assets: gamePhaseModel!.assets)
        setupBackgroundList()
        setupCircle()
    }

}

extension FlagScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            guard let touchedFirst = touchedNodes.first?.name else { return }
            if !(self.backgroundList.contains(touchedFirst)) &&
                !(lockScreenInteraction!) &&
                !(touchedFirst == "pause") &&
                !(touchedFirst == "setup") {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    touchedNodes.first?.zPosition = CGFloat(lastZPos)
                    self.currentNode = touchedNodes.first
                if let node = currentNode {
                    self.lastXYpos = [node.position.x, node.position.y]
                }
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

            if let touch = touches.first, let _ = self.currentNode {
                let touchLocation = touch.location(in: self)
                let touchedNodes = self.nodes(at: touchLocation)
                for item in backgroundList {
                    scene?.enumerateChildNodes(withName: item, using: { node, _ in
                        let intersectPositionX: Bool =
                        (self.currentNode?.position.x)! >= (node.frame.minX) &&
                        (self.currentNode?.position.x)! <= (node.frame.maxX) ?
                        true : false
                        let intersectPositionY: Bool =
                        (self.currentNode?.position.y)! >= (node.frame.minY) &&
                        (self.currentNode?.position.y)! <= (node.frame.maxY) ?
                        true : false

                        if intersectPositionX && intersectPositionY {
                            if Int((self.currentNode?.name)!) == self.backgroundList.firstIndex(of: node.name!) {
                                node.alpha = 1.0
                                self.currentNode?.alpha = 0.0
                                self.colorList += 1
                                if self.colorList == 3 {
                                    self.pressButton()
                                }
                            }
                        } else {
                            if !(self.lastXYpos.isEmpty) {
                                self.currentNode?.position = CGPoint(x: self.lastXYpos[0], y: self.lastXYpos[1])
                            }
                        }
                    })
                }
            }
        }
        self.currentNode = nil
    }

    private func pressButton() {
        customDelegate?.didUpdateData(data: 1)
        didPressButton?()
    }
}

extension FlagScene {

    func setupBottomBar() {
        let bottomNode = SKSpriteNode(imageNamed: (gamePhaseModel?.assets[0])!)
        if viewHeight < 700 {
            bottomNode.size = CGSize(width: viewWidth-(viewWidth/4), height: viewHeight/8)
            bottomNode.position = CGPoint(x: (view?.center.x)!, y: viewHeight/8)
        } else {
            bottomNode.size = CGSize(width: viewWidth-(viewWidth/4), height: viewHeight/10)
            bottomNode.position = CGPoint(x: (view?.center.x)!, y: viewHeight/8)
        }
        bottomNode.name = "setup"
        addChild(bottomNode)
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

        for image in filteredAssets {

            let tempImage = UIImage(named: image)

            let backgroundTexture = SKTexture(image: tempImage!)

            let background = SKSpriteNode(texture: backgroundTexture)
            if viewHeight < 700 {
                background.size = CGSize(
                    width: ((view?.frame.width)!*0.85),
                    height: ((view?.frame.height)!*0.52)
                )
                background.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)! + viewHeight/10)
            } else {
                background.size = CGSize(
                    width: ((view?.frame.width)!*0.95),
                    height: ((view?.frame.height)!*0.45)
                )
                background.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)! + viewHeight/15)
            }
            background.zPosition = -10
            if image != filteredAssets.first {
                background.alpha = 0.0
                background.name = image
                background.zPosition = 50
            } else {
                background.name = "setup"
            }
            addChild(background)
        }
    }

    private func pauseScreenInteraction() {
        lockScreenInteraction = false
    }

    private func setupBackgroundList() {
        for index in 2...4 {
            self.backgroundList.append((gamePhaseModel?.assets[index])!)
        }
    }

    func setupCircle() {

        if viewHeight < 700 {
            let circle = SKShapeNode(circleOfRadius: 30) // Create circle
            circle.position = CGPoint(x: (scene?.size.width)!*0.25, y: viewHeight/3.8)
            circle.strokeColor = SKColor.black
            circle.glowWidth = 1.0
            circle.fillColor = UIColor(red: 0/255, green: 140/255, blue: 69/255, alpha: 1.0)
            circle.name = "0"
            addChild(circle)

            let circle2 = SKShapeNode(circleOfRadius: 30) // Create circle
            circle2.position = CGPoint(x: (scene?.size.width)!*0.5, y: viewHeight/3.8)
            circle2.strokeColor = SKColor.black
            circle2.glowWidth = 1.0
            circle2.fillColor = UIColor(red: 244/255, green: 249/255, blue: 255/255, alpha: 1.0)
            circle2.name = "1"
            addChild(circle2)

            let circle3 = SKShapeNode(circleOfRadius: 30) // Create circle
            circle3.position = CGPoint(x: (scene?.size.width)!*0.75, y: viewHeight/3.8)
            circle3.strokeColor = SKColor.black
            circle3.glowWidth = 1.0
            circle3.fillColor = UIColor(red: 205/255, green: 33/255, blue: 42/255, alpha: 1.0)
            circle3.name = "2"
            addChild(circle3)
        } else {
            let circle = SKShapeNode(circleOfRadius: 40) // Create circle
            circle.position = CGPoint(x: (scene?.size.width)!*0.25, y: viewHeight/4)
            circle.strokeColor = SKColor.black
            circle.glowWidth = 1.0
            circle.fillColor = UIColor(red: 0/255, green: 140/255, blue: 69/255, alpha: 1.0)
            circle.name = "0"
            addChild(circle)

            let circle2 = SKShapeNode(circleOfRadius: 40) // Create circle
            circle2.position = CGPoint(x: (scene?.size.width)!*0.5, y: viewHeight/4)
            circle2.strokeColor = SKColor.black
            circle2.glowWidth = 1.0
            circle2.fillColor = UIColor(red: 244/255, green: 249/255, blue: 255/255, alpha: 1.0)
            circle2.name = "1"
            addChild(circle2)

            let circle3 = SKShapeNode(circleOfRadius: 40) // Create circle
            circle3.position = CGPoint(x: (scene?.size.width)!*0.75, y: viewHeight/4)
            circle3.strokeColor = SKColor.black
            circle3.glowWidth = 1.0
            circle3.fillColor = UIColor(red: 205/255, green: 33/255, blue: 42/255, alpha: 1.0)
            circle3.name = "2"
            addChild(circle3)
        }
    }
}
