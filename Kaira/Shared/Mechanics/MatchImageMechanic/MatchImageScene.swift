import SpriteKit
// swiftlint: disable all

class MatchImageScene: SKScene, SKPhysicsContactDelegate {

    var gamePhaseModel: GamePhaseModel?

    weak var customDelegate: DataDelegate?

    var didPressButton: (() -> Void)?

    var lockScreenInteraction: Bool?

    var currentNode: SKNode?

    var lastZPos = 1
    var lastXYpos: [CGFloat] = []

    var XposArray: [CGFloat] = []
    var YposArray: [CGFloat] = []

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
        print(XposArray)
        print(YposArray)
        setupPositionals()
        setupBottomBar()
        setupButtons()
        setupSprites(assets: gamePhaseModel!.assets)
    }

}

extension MatchImageScene {

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

                        if touchedNodes.count <= 2 {
                            if intersectPositionX && intersectPositionY {
                                if self.verifyColor(self.currentNode!, node) {
                                    self.currentNode?.position = CGPoint(x: (node.position.x), y: (node.position.y))
                                    if (node.name?.contains("on"))! {
                                        node.alpha = 1.0
                                    } else {
                                        node.alpha = 0.0
                                    }
                                    self.currentNode?.alpha = 0.0
                                    if self.didWon() {
                                        self.pressButton()
                                    }
                                } else {
                                    if !(self.lastXYpos.isEmpty) {
                                        self.currentNode?.position = CGPoint(x: self.lastXYpos[0], y: self.lastXYpos[1])
                                    }
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

extension MatchImageScene {

    func verifyColor(_ current: SKNode, _ state: SKNode) -> Bool {
        let values = ["blue", "green", "orange", "pink", "purple", "red"]
        for item in values {
            if (current.name?.contains(item))! && (state.name?.contains(item))! {
                return true
            }
        }
        return false
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

        let splitList3 = filteredAssets.filter({ $0.contains("image") })

        let onofflist = filteredAssets.filter({ !splitList3.contains($0) })

        var iteratorX = 0
        var iteratorY = 0
        var iteratorList = 0
        for _ in 0...5 {

            let tempImage = UIImage(named: onofflist[iteratorList])
            let backgroundTexture = SKTexture(image: tempImage!)

            let background = SKSpriteNode(texture: backgroundTexture)
            background.name = onofflist[iteratorList]
            background.size = CGSize(width: viewHeight/9, height: viewHeight/9)
            background.position = CGPoint(x: self.XposArray[iteratorX], y: self.YposArray[iteratorY])
            background.zPosition = -10
            addChild(background)

            //

            let tempImage1 = UIImage(named: onofflist[iteratorList+1])
            let backgroundTexture1 = SKTexture(image: tempImage1!)

            let background1 = SKSpriteNode(texture: backgroundTexture1)
            background1.name = onofflist[iteratorList+1]
            background1.size = CGSize(width: viewHeight/9, height: viewHeight/9)
            background1.position = CGPoint(x: self.XposArray[iteratorX], y: self.YposArray[iteratorY])
            background1.zPosition = -10
            background1.alpha = 0.0
            addChild(background1)

            //

            iteratorX += 1
            iteratorList += 2
            if iteratorX > 2 {
                iteratorX = 0
                iteratorY += 1
                if iteratorY > 1 {
                    iteratorY = 0
                }
            }
        }

        iteratorX = 0
        iteratorY = 0
        iteratorList = 0

        var randomList: [CGPoint] = [
            CGPoint(x: XposArray[0], y: YposArray[2]),
            CGPoint(x: XposArray[1], y: YposArray[2]),
            CGPoint(x: XposArray[2], y: YposArray[2]),
            CGPoint(x: XposArray[0], y: YposArray[3]),
            CGPoint(x: XposArray[1], y: YposArray[3]),
            CGPoint(x: XposArray[2], y: YposArray[3]),
        ]

        for _ in 0...5 {

            let tempImage2 = UIImage(named: splitList3[iteratorList])
            let backgroundTexture2 = SKTexture(image: tempImage2!)

            let background2 = SKSpriteNode(texture: backgroundTexture2)
            background2.name = splitList3[iteratorList]
            background2.size = CGSize(width: viewHeight/9, height: viewHeight/9)

            let posValue = randomList.randomElement()
            randomList.removeAll(where: { $0 == posValue })

            if let posValue {
                background2.position = posValue
            }

            background2.zPosition = -10
            addChild(background2)

            iteratorList += 1
        }

        setupBackgroundList(onofflist)
        print(onofflist)
        print(backgroundList)
    }

    private func pauseScreenInteraction() {
        lockScreenInteraction = false
    }

    private func setupBackgroundList(_ array: [String]) {
        self.backgroundList = array
    }

    private func didWon() -> Bool {
        let onList = backgroundList.filter({ $0.contains("on") })
        var check = 0
        for item in onList {
            scene?.enumerateChildNodes(withName: item, using: { node, _ in
                if node.alpha == 1.0 {
                    check += 1
                }
            })
        }
        if check == 6 {
            return true
        } else {
            return false
        }
    }

    func setupPositionals() {

        let Xpos1 = viewWidth*0.25 // 25% --
        let Xpos2 = viewWidth*0.5 // 50% --
        let Xpos3 = viewWidth*0.75 // 75% --

        let Ypos1 = viewHeight*0.75 // 75%
        let Ypos2 = viewHeight*0.6 // 65%
        let Ypos3 = viewHeight*0.45 // 40% --
        let Ypos4 = viewHeight*0.3 // 30% --

        self.XposArray = [
            Xpos1, Xpos2, Xpos3
        ]

        self.YposArray = [
            Ypos1, Ypos2, Ypos3, Ypos4
        ]
    }
}
