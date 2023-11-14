struct SpainPhaseStructure: PhaseStructure {
    // swiftlint: disable all
    let name = "Test"
    var historyVC: [HistoryViewController] = []
    var historyPages: [HistoryPageModel] = []
    var customDelegate: DataDelegate?

    init(_ customDelegate: DataDelegate) {
//        let spainGamePhaseModel = GamePhaseModel(countryName: "Spain", background: "pause-background", assets: [
//            "dnd-game-objective",
//            "dnd-objective-3", //1
//            "dnd-objective-2", //2
//            "dnd-objective-5", //3
//            "dnd-objective-1", //4
//            "dnd-objective-4", //5
//            "dnd-image-1", //6
//            "dnd-winner-5", //7
//            "dnd-image-5", //8
//            "dnd-winner-2", //9
//            "dnd-winner-3", //10
//            "dnd-image-3", //11
//            "dnd-winner-4", //12
//            "dnd-winner-1" //13
//        ])

        let spainGamePhaseModel = GamePhaseModel(countryName: "Japan", background: "pause-background", assets: [
            "japan-game-2-objective",
            "japan-game-2-objective-image", //1
            "japan-game-2-objective-image", //2
            "japan-game-2-objective-image", //3
            "japan-dnd-image-1", //4
            "japan-dnd-image-2", //5
            "japan-dnd-image-3", //6
            "japan-dnd-image-4", //7
            "japan-dnd-image-5", //8
            "japan-dnd-image-6", //9
            "japan-dnd-image-7", //10
            "japan-dnd-image-8", //11
            "japan-dnd-image-9" //12
        ])

        let spainGame = DragAndDropViewController()
        spainGame.gamePhaseModel = spainGamePhaseModel
        spainGame.customDelegate = customDelegate

        let unlockSpainStampView = UnlockedStampViewController(
            stampImage: "spain-selo",
            label: String(localized: "SpainUnlockStampTextLocalized"),
            onFinishButtonPressed: nil
        )

        self.historyPages = [
            HistoryPageModel(
                image: "spain-1",
                text: String(localized: "SpainHistoryTextLocalized"),
                button: .next,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-2",
                text: String(localized: "SpainHistoryTextLocalized2"),
                button: .next,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-3",
                text: String(localized: "SpainHistoryTextLocalized3"),
                button: .next,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-4",
                text: String(localized: "SpainHistoryTextLocalized4"),
                button: .finish,
                nextViewController: spainGame,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-5",
                text: String(localized: "SpainHistoryTextLocalized5"),
                button: .next,
                nextViewController: unlockSpainStampView,
                skipViewController: unlockSpainStampView
            ),
        ]

        self.historyVC = [
            HistoryViewController(historyPages: [self.historyPages[0], self.historyPages[1], self.historyPages[2], self.historyPages[3]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[4]]) {
                    customDelegate.didUpdateData(data: 1)
            }
        ]

        spainGame.historyViewController = self.historyVC[1]
    }
}
