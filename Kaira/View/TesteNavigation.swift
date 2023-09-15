import UIKit
import SpriteKit

protocol DataDelegate: AnyObject {
    func didUpdateData(data: Int)
}

class TesteNavigation: SKScene {

    weak var customDelegate: DataDelegate?

    override func didMove(to view: SKView) {
        let button = UIButton(type: .system)
        button.setTitle("Meu Botão", for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.addTarget(self, action: #selector(botaoTocado), for: .touchUpInside)
        let skView = view
        skView.addSubview(button)
    }

    @objc func botaoTocado() {
        let botaoPress = Int.random(in: 1...11)
        print("\(botaoPress)")
        customDelegate?.didUpdateData(data: botaoPress + 1)
    }
}
