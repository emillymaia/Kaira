struct EnglandPhaseStructure: PhaseStructure {
    // swiftlint: disable all
    let name = "England"
    var historyVC: [HistoryViewController] = []
    var historyPages: [HistoryPageModel] = []

    var customDelegate: DataDelegate?

    init(_ customDelegate: DataDelegate) {
//        let englandGamePhaseModel = GamePhaseModel(countryName: "England", background: "", assets: [ // interpolar string
//            "england-game-objective",
//            "england-game-winner",
//            "england-game-image-1",
//            "england-game-image-2",
//            "england-game-image-3",
//            "england-game-image-4",
//        ])

        let englandGamePhaseModel = GamePhaseModel(countryName: "Japan", background: "", assets: [ // interpolar string
            "japan-game-objective",
            "japan-game-winner",
            "japan-game-image-1",
            "japan-game-image-2",
            "japan-game-image-3",
            "japan-game-image-4",
        ])

        let englandFindGame = FindImageViewController()
        englandFindGame.gamePhaseModel = englandGamePhaseModel
        englandFindGame.customDelegate = customDelegate
        let unlockEnglandStampView = UnlockedStampViewController(
            stampImage: "england-selo",
            label: String(localized:"EnglandUnlockStampTextLocalized"),
            onFinishButtonPressed: nil
        )

        self.historyPages = [
            HistoryPageModel(
                image: "england-1",
                text: String(localized: "EnglandHistoryTextLocalized1"),
                button: .next,
                skipViewController: englandFindGame
            ),
            HistoryPageModel(
                image: "england-2",
                text: String(localized: "EnglandHistoryTextLocalized2"),
                button: .finish,
                nextViewController: englandFindGame,
                skipViewController: englandFindGame
            ),
            HistoryPageModel(
                image: "england-3",
                text: String(localized: "EnglandHistoryTextLocalized3"),
                button: .next,
                skipViewController: unlockEnglandStampView
            ),
            HistoryPageModel(
                image: "england-4",
                text: String(localized: "EnglandHistoryTextLocalized4"),
                button: .next,
                nextViewController: unlockEnglandStampView,
                skipViewController: unlockEnglandStampView
            ),
        ]

        self.historyVC = [
            HistoryViewController(historyPages: [self.historyPages[0], self.historyPages[1]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[2], self.historyPages[3]]) {
                    customDelegate.didUpdateData(data: 1)
            }
        ]

        englandFindGame.historyViewController = self.historyVC[1]
    }
}
