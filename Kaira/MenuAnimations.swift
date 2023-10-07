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
    private func animateClick() {
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
