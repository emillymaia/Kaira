import UIKit

extension UIButton {
    func animateClick() {
        let initialScale: CGFloat = 0.8

        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: initialScale, y: initialScale)
        }) { _ in

            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
}

extension UILabel {
    func typeWriter(label: String, characterDelay: TimeInterval = 0.04) {
        DispatchQueue.global().async {
            var text = ""

            for (index, char) in label.enumerated() {
                if char == "*" {
                    text.append(char)
                } else {
                    text.append(char)
                    DispatchQueue.main.async {
                        self.text = text
                    }
                    Thread.sleep(forTimeInterval: characterDelay)
                }

                if index == label.count - 1 {
                    print("animou")
                }
            }
        }
    }
}

extension HistoryViewController {
    private func haptic() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
}
