import UIKit
import SpriteKit

var textChapter1IntroView = "O que é isso? Onde estou? Eu me lembro desse lugar, mas algo está faltando! Preciso da sua ajuda para reconstruir essa memória"

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

var pagesChapter1IntroView: [HistoryPageModel] = [
    HistoryPageModel(image: "OBJ1", text: textChapter1IntroView, button: .finish,
                     nextViewController: Chapter1GameViewController())
]

var chapter1IntroView = HistoryViewController(historyPages: pagesChapter1IntroView) {
    print("foi")
}
