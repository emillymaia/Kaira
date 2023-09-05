import Foundation
import SpriteKit

class HiddenObjectScene: SKScene {
    private var background: SKSpriteNode!
    var hiddenObject: SKSpriteNode!
    private var alert: SKLabelNode?

    func setupScene(backgroundAsset: String, hiddenObjectAsset: String) {
        background = SKSpriteNode(imageNamed: backgroundAsset)
        hiddenObject = SKSpriteNode(imageNamed: hiddenObjectAsset)
        addChilds()
        setupObjectSize()
        setupObjectPosition()
    }

    private func addChilds() {
        addChild(background)
        addChild(hiddenObject)
    }

    private func setupObjectPosition() {
        let maxX = size.width
        let maxY = size.height
        let xCoord = CGFloat.random(in: 50...(maxX - 50))
        let yCoord = CGFloat.random(in: 50...(maxY - 200))

        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        hiddenObject.position = CGPoint(x: xCoord, y: yCoord)

    }

    private func setupObjectSize() {
        hiddenObject.size = CGSize(width: 20, height: 20)
    }

    func showHiddenObjectAlert() {
        alert = SKLabelNode(text: "Você encontrou o objeto!")
        alert?.position = CGPoint(x: size.width / 2, y: size.height - 50)
        alert?.fontSize = 24
        addChild(alert!)
        hiddenObject.removeFromParent()
    }
}
