import SpriteKit

class Inicio: SKScene, SKPhysicsContactDelegate {

    weak var menuViewController: UIViewController?

    weak var customDelegate: DataDelegate?

    var setter: Int?

    override func didMove(to view: SKView) {
        createBackground()
    }
}

extension Inicio {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        let scene = Challenge()
        scene.size = self.size
        scene.scaleMode = .aspectFill
        scene.setter = self.setter
        scene.customDelegate = self.customDelegate
        view?.presentScene(scene)
    }
}

extension Inicio {
    func createBackground() {

        guard let image = UIImage(named: "OBJ1") else { return }

        let backgroundTexture = SKTexture(image: image)

        for _ in 0 ... 1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.size = CGSize(width: (view?.frame.width)!/2, height: (view?.frame.height)!/2)
            background.name = "background"
            background.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)!)
            background.zPosition = -5
            addChild(background)
        }

        guard let image2 = UIImage(named: "background-test") else { return }

        let backgroundTexture2 = SKTexture(image: image2)

        for _ in 0 ... 1 {
            let background = SKSpriteNode(texture: backgroundTexture2)
            background.size = CGSize(width: (view?.frame.width)!, height: (view?.frame.height)!)
            background.name = "background"
            background.position = CGPoint(x: (view?.center.x)!, y: (view?.center.y)!)
            background.zPosition = -10
            addChild(background)
        }

        let label = SKLabelNode()
        label.text = "Ache o Relógio"
        label.position = CGPoint(x: (view?.center.x)!, y: 100)
        label.zPosition = 1
        label.fontColor = .black
        addChild(label)
    }
}
