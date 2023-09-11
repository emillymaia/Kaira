import UIKit
import SpriteKit

// classe  temporária, criada para testar a visualização da mecânica
final class HiddenObjectViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = SKView(frame: self.view.frame)
        let scene = HiddenObjectScene(size: view.bounds.size)
        skView.presentScene(scene)
        view.addSubview(skView)
        scene.setupScene(backgroundAsset: " ", hiddenObjectAsset: " ")

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        skView.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        _ = sender.location(in: sender.view)
//        if let scene = sender.view as? HiddenObjectScene,
//           let hiddenObject = scene.hiddenObject,
//           hiddenObject.frame.contains(touchLocation) {
//            scene.showHiddenObjectAlert()
//        }
    }
}
