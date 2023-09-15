import SpriteKit

class Thanks: SKScene, SKPhysicsContactDelegate {

    weak var menuViewController: UIViewController?

    weak var customDelegate: DataDelegate?

    override func didMove(to view: SKView) {
        createBackground()
    }
}

extension Thanks {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        customDelegate?.didUpdateData(data: 2)
    }
}

extension Thanks {
    func createBackground() {

        guard let image = UIImage(named: "thanks") else { return }
//        let scaledImage = image?.scalePreservingAspectRatio(
//            targetSize: CGSize(
//                width: (view?.frame.width)!,
//                height: (view?.frame.height)!
//            )
//        )

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
    }
}
