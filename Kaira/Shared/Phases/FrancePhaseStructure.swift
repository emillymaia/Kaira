struct FrancePhaseStructure: PhaseStructure {
    // swiftlint: disable all
    let name = "France"
    var historyVC: [HistoryViewController] = []
    var historyPages: [HistoryPageModel] = []

    init(_ customDelegate: DataDelegate) {
        let franceSignGamePhaseModel = GamePhaseModel(countryName: "France", background: "france-game-2-background", assets: [
            "\(name.lowercased())-game-2-objective"
        ])

        let franceFindGamePhaseModel = GamePhaseModel(countryName: "France", background: "", assets: [
            "\(name.lowercased())-game-objective",
            "\(name.lowercased())-game-winner",
            "\(name.lowercased())-game-image-1",
            "\(name.lowercased())-game-image-2",
            "\(name.lowercased())-game-image-3"
        ])

        let franceSignGame = SignatureViewController()
        franceSignGame.gamePhaseModel = franceSignGamePhaseModel
        franceSignGame.customDelegate = customDelegate

        let franceFindGame = FindImageViewController()
        franceFindGame.gamePhaseModel = franceFindGamePhaseModel
        franceFindGame.customDelegate = customDelegate

        let unlockFranceStampView = UnlockedStampViewController(
            stampImage: "france-selo",
            label: String(localized: "FranceUnlockStampTextLocalized"),
            onFinishButtonPressed: nil
        )

        self.historyPages = [
            HistoryPageModel(
                image: "france-1",
                text: String(localized: "FranceHistoryTextLocalized1"),
                button: .next,
                skipViewController: franceSignGame
            ),
            HistoryPageModel(
                image: "france-2",
                text: String(localized: "FranceHistoryTextLocalized2"),
                button: .next,
                skipViewController: franceSignGame
            ),
            HistoryPageModel(
                image: "france-3",
                text: String(localized: "FranceHistoryTextLocalized3"),
                button: .finish,
                nextViewController: franceSignGame,
                skipViewController: franceSignGame
            ),
            HistoryPageModel(
                image: "france-4",
                text: String(localized: "FranceHistoryTextLocalized4"),
                button: .next,
                skipViewController: franceFindGame
            ),
            HistoryPageModel(
                image: "france-5",
                text: String(localized: "FranceHistoryTextLocalized5"),
                button: .finish,
                nextViewController: franceFindGame,
                skipViewController: franceFindGame
            ),
            HistoryPageModel(
                image: "france-6",
                text: String(localized: "FranceHistoryTextLocalized6"),
                button: .next,
                nextViewController: unlockFranceStampView,
                skipViewController: unlockFranceStampView
            )
        ]

        self.historyVC = [
            HistoryViewController(historyPages: [self.historyPages[0], self.historyPages[1], self.historyPages[2]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[3], self.historyPages[4]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[5]]) {
                    customDelegate.didUpdateData(data: 2)
            }
        ]

        franceSignGame.historyViewController = self.historyVC[1]
        franceFindGame.historyViewController = self.historyVC[2]
    }
}
