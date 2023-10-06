//
//  UnlockedStampView.swift
//  Kaira
//
//  Created by Emilly Maia on 06/10/23.
//

import UIKit

class UnlockedStampView: UIView {
    var didPressButton: (() -> Void)?

    var stampImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    var text: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Pally-Regular", size: 17)
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()

    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func pressButton() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        didPressButton?()
    }
}

extension UnlockedStampView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stampImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 96),
            stampImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            stampImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            stampImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -307),

            text.topAnchor.constraint(equalTo: stampImage.bottomAnchor, constant: 24),
            text.leadingAnchor.constraint(equalTo: stampImage.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: stampImage.trailingAnchor),

            button.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 8),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 313),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -23)
        ])
    }

    func addSubviews() {
        addSubview(stampImage)
        addSubview(text)
        addSubview(button)
    }
}