struct ItalyPhaseStructure: PhaseStructure {
    // swiftlint: disable all
    let name = "Italy"
    var historyVC: [HistoryViewController] = []
    var historyPages: [HistoryPageModel] = []

    init(_ customDelegate: DataDelegate) {
        let italyFlagGamePhaseModel = GamePhaseModel(countryName: "Italy", background: "", assets: [
            "\(name.lowercased())-flag-objective",
            "\(name.lowercased())-flag-background",
            "\(name.lowercased())-flag-1",
            "\(name.lowercased())-flag-2",
            "\(name.lowercased())-flag-3",
        ])

        let italyMatchImageGamePhaseModel = GamePhaseModel(countryName: "Italy", background: "", assets: [
            "\(name.lowercased())-mi-objective",
            "\(name.lowercased())-mi-blue-image",
            "\(name.lowercased())-mi-blue-off",
            "\(name.lowercased())-mi-blue-on",
            "\(name.lowercased())-mi-green-image",
            "\(name.lowercased())-mi-green-off",
            "\(name.lowercased())-mi-green-on",
            "\(name.lowercased())-mi-orange-image",
            "\(name.lowercased())-mi-orange-off",
            "\(name.lowercased())-mi-orange-on",
            "\(name.lowercased())-mi-pink-image",
            "\(name.lowercased())-mi-pink-off",
            "\(name.lowercased())-mi-pink-on",
            "\(name.lowercased())-mi-purple-image",
            "\(name.lowercased())-mi-purple-off",
            "\(name.lowercased())-mi-purple-on",
            "\(name.lowercased())-mi-red-image",
            "\(name.lowercased())-mi-red-off",
            "\(name.lowercased())-mi-red-on",
        ])

        let italyFlagGame = FlagViewController()
        italyFlagGame.gamePhaseModel = italyFlagGamePhaseModel
        italyFlagGame.customDelegate = customDelegate

        let italyMatchImageGame = MatchImageViewController()
        italyMatchImageGame.gamePhaseModel = italyMatchImageGamePhaseModel
        italyMatchImageGame.customDelegate = customDelegate

        let unlockItalyStampView = UnlockedStampViewController(
            stampImage: "italy-selo",
            label: String(localized: "ItalyUnlockStampTextLocalized"),
            onFinishButtonPressed: nil
        )

        self.historyPages = [
            HistoryPageModel(
                image: "italy-1",
                text: String(localized: "ItalyHistoryTextLocalized1"),
                button: .next,
                skipViewController: italyFlagGame
            ),
            HistoryPageModel(
                image: "italy-2",
                text: String(localized: "ItalyHistoryTextLocalized2"),
                button: .finish,
                nextViewController: italyFlagGame,
                skipViewController: italyFlagGame
            ),
            HistoryPageModel(
                image: "italy-3",
                text: String(localized: "ItalyHistoryTextLocalized3"),
                button: .next,
                skipViewController: italyMatchImageGame
            ),
            HistoryPageModel(
                image: "italy-4",
                text: String(localized: "ItalyHistoryTextLocalized4"),
                button: .next,
                skipViewController: italyMatchImageGame
            ),
            HistoryPageModel(
                image: "italy-5",
                text: String(localized: "ItalyHistoryTextLocalized5"),
                button: .finish,
                nextViewController: italyMatchImageGame,
                skipViewController: italyMatchImageGame
            ),
            HistoryPageModel(
                image: "italy-6",
                text: String(localized: "ItalyHistoryTextLocalized6"),
                button: .next,
                nextViewController: unlockItalyStampView,
                skipViewController: unlockItalyStampView
            )
        ]

        self.historyVC = [
            HistoryViewController(historyPages: [self.historyPages[0], self.historyPages[1]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[2], self.historyPages[3], self.historyPages[4]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[5]]) {
                    customDelegate.didUpdateData(data: 1)
            }
        ]

        italyFlagGame.historyViewController = self.historyVC[1]
        italyMatchImageGame.historyViewController = self.historyVC[2]
    }
}
