import UIKit
import SpriteKit

class Chapter1GameViewController: UIViewController {
    var skView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()

        skView = SKView(frame: view.frame)
        skView.showsFPS = true
        skView.showsNodeCount = true
        view.addSubview(skView)

        let scene = Challenge(size: skView.bounds.size)
        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
    }
}
