import SpriteKit
// swiftlint: disable all

class DragAndDropScene: SKScene, SKPhysicsContactDelegate {

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
        setupPositionals()
        setupBottomBar()
        setupButtons()
        setupSprites(assets: gamePhaseModel!.assets)
        setupBackgroundList()
    }

}

extension DragAndDropScene {

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

                        if touchedNodes.count <= 2 {
                            if intersectPositionX && intersectPositionY {
                                self.currentNode?.position = CGPoint(x: (node.position.x), y: (node.position.y))
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

        if didWon() {
            pressButton()
        }
    }

    private func pressButton() {
        customDelegate?.didUpdateData(data: 1)
        didPressButton?()
    }
}

extension DragAndDropScene {

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

        var iteratorX = 0
        var iteratorY = 0
        for image in filteredAssets {

            let tempImage = UIImage(named: image)

            let backgroundTexture = SKTexture(image: tempImage!)

            let background = SKSpriteNode(texture: backgroundTexture)
            background.name = image
            background.size = CGSize(width: viewHeight/9, height: viewHeight/9)
            background.position = CGPoint(x: self.XposArray[iteratorX], y: self.YposArray[iteratorY])
            background.zPosition = -10
            addChild(background)

            iteratorX += 1
            iteratorY += 1
        }
    }

    private func pauseScreenInteraction() {
        lockScreenInteraction = false
    }

    private func setupBackgroundList() {
        for index in 1...5 {
            self.backgroundList.append((gamePhaseModel?.assets[index])!)
        }
    }

    private func didWon() -> Bool {
        guard let gameNodes = gamePhaseModel?.assets else { return false }

        let verify1: Bool = childNode(withName: gameNodes[1])?.position ==
        childNode(withName: gameNodes[10])?.position ? true : false
        let verify2: Bool = childNode(withName: gameNodes[2])?.position ==
        childNode(withName: gameNodes[9])?.position ? true : false
        let verify3: Bool = childNode(withName: gameNodes[3])?.position ==
        childNode(withName: gameNodes[7])?.position ? true : false
        let verify4: Bool = childNode(withName: gameNodes[4])?.position ==
        childNode(withName: gameNodes[13])?.position ? true : false
        let verify5: Bool = childNode(withName: gameNodes[5])?.position ==
        childNode(withName: gameNodes[12])?.position ? true : false

        if verify1 && verify2 && verify3 && verify4 && verify5 {
            return true
        }
        return false
    }

    func setupPositionals() {
        let Xpos1 = viewWidth*0.33 //33%
        let Xpos2 = viewWidth*0.66 // 66% --
        let Xpos3 = viewWidth*0.25 // 25% --
        let Xpos4 = viewWidth*0.5 // 50% --
        let Xpos5 = viewWidth*0.75 // 75% --

        let Ypos1 = viewHeight*0.75 // 75%
        let Ypos2 = viewHeight*0.65 // 65%
        let Ypos3 = viewHeight*0.5 // 50% --
        let Ypos4 = viewHeight*0.4 // 40% --
        let Ypos5 = viewHeight*0.3 // 30% --

        self.XposArray = [
            Xpos1, Xpos2, Xpos3, Xpos4, Xpos5,
            Xpos1, Xpos2, Xpos3, Xpos4, Xpos5,
            Xpos3, Xpos4, Xpos5,
        ]

        self.YposArray = [
            Ypos1, Ypos1, Ypos2, Ypos2, Ypos2,
            Ypos3, Ypos3, Ypos4, Ypos4, Ypos4,
            Ypos5, Ypos5, Ypos5
        ]
    }
}
