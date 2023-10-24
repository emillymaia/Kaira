import SpriteKit

class CustomPopup: SKSpriteNode {
    private var backToMenuButton: SKSpriteNode!
    private var soundEffectButton: SKSpriteNode!
    private var backgroundSoundButton: SKSpriteNode!
    private var dismissButton: SKSpriteNode!
    private var isSoundEffectOn = true
    var isBackgroundSoundOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isBackgroundSoundOn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isBackgroundSoundOn")
        }
    }
    var navController: UIViewController?
    var didClose: (() -> Void)?

    init() {
        let texture = SKTexture(imageNamed: "pause-background")
        super.init(texture: texture, color: .clear, size: texture.size())

        self.zPosition = 1
        self.isUserInteractionEnabled = true

        let popupSize = CGSize(width: 250, height: 260)
        self.size = popupSize

        let label = SKLabelNode()
        label.text = "Paused"
        label.position = CGPoint(x: 0, y: -popupSize.height / 2 + 215)
        label.fontColor = .black
        label.fontName = "Pally-Bold"
        addChild(label)

        soundEffectButton = SKSpriteNode(imageNamed: "SoundOn")
        soundEffectButton.position = CGPoint(x: 2-30, y: -popupSize.height / 2 + 170)
        soundEffectButton.name = "soundEffectButton"
        soundEffectButton.size = CGSize(width: 50, height: 50)
        self.addChild(soundEffectButton)

        backgroundSoundButton = SKSpriteNode(imageNamed: "MusicOn")
        backgroundSoundButton.position = CGPoint(x: 2+30, y: -popupSize.height / 2 + 170)
        backgroundSoundButton.name = "backgroundSoundButton"
        backgroundSoundButton.size = CGSize(width: 50, height: 50)
        self.addChild(backgroundSoundButton)

        backToMenuButton = SKSpriteNode(imageNamed: "BackToMenuButton")
        backToMenuButton.position = CGPoint(x: 0, y: -popupSize.height / 2 + 40)
        backToMenuButton.name = "backToMenuButton"
        backToMenuButton.size = CGSize(width: 195, height: 50)
        self.addChild(backToMenuButton)

        dismissButton = SKSpriteNode(imageNamed: "ContinueButton")
        dismissButton.position = CGPoint(x: 0, y: -popupSize.height / 2 + 100)
        dismissButton.name = "dismissButton"
        dismissButton.size = CGSize(width: 145, height: 50)
        self.addChild(dismissButton)

        isSoundEffectOn = UserDefaults.standard.bool(forKey: "isSoundEffectOn")
        isBackgroundSoundOn = UserDefaults.standard.bool(forKey: "isBackgroundSoundOn")

        let soundEffectTextureName = isSoundEffectOn ? "SoundOn" : "SoundOff"
        soundEffectButton.texture = SKTexture(imageNamed: soundEffectTextureName)

        let backgroundSoundTextureName = isBackgroundSoundOn ? "MusicOn" : "MusicOff"
        backgroundSoundButton.texture = SKTexture(imageNamed: backgroundSoundTextureName)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodesAtLocation = self.nodes(at: location)

            for node in nodesAtLocation {
                if node.name == "soundEffectButton" {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    isSoundEffectOn.toggle()
                    let textureName = isSoundEffectOn ? "SoundOn" : "SoundOff"
                    soundEffectButton.texture = SKTexture(imageNamed: textureName)

                    UserDefaults.standard.set(isSoundEffectOn, forKey: "isSoundEffectOn")
                } else if node.name == "backgroundSoundButton" {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    isBackgroundSoundOn.toggle()
                    let textureName = isBackgroundSoundOn ? "MusicOn" : "MusicOff"
                    backgroundSoundButton.texture = SKTexture(imageNamed: textureName)

                    UserDefaultsManager.shared.isBackgroundSoundOn = isBackgroundSoundOn

                    if isBackgroundSoundOn {
                        startMusic()
                    } else {
                        pauseMusic()
                    }
                } else if node.name == "dismissButton" {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    self.close()
                } else if node.name == "backToMenuButton" {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    navController!.dismiss(animated: true)
                }
            }
        }
    }

    func close() {
        didClose?()
        self.removeFromParent()
    }
}

extension CustomPopup {
    func startMusic() {
        SoundManager.shared.playBackgroundMusic("backgroundSound")
    }

    func pauseMusic() {
        SoundManager.shared.stopBackgroundMusic()
    }
}
