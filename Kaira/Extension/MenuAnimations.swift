import Foundation

import UIKit

extension HistoryViewController {
    private func haptic() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
}

extension MenuCollectionCellView {
    func animateClick() {
        let initialScale: CGFloat = 0.9

        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: initialScale, y: initialScale)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }
    }
}

extension UICollectionViewCell {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

extension MenuViewController {
    func haptic() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }

    func startMusic() {
        let queue = DispatchQueue.global(qos: .background)

        queue.async {
            SoundManager.shared.playBackgroundMusic("backgroundSound")
        }
    }
}
