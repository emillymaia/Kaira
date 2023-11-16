struct SpainPhaseStructure: PhaseStructure {
    // swiftlint: disable all
    let name = "Test"
    var historyVC: [HistoryViewController] = []
    var historyPages: [HistoryPageModel] = []
    var customDelegate: DataDelegate?

    init(_ customDelegate: DataDelegate) {
        let spainGamePhaseModel = GamePhaseModel(countryName: "Spain", background: "pause-background", assets: [
            "dnd-game-objective",
            "dnd-objective-3", //1
            "dnd-objective-2", //2
            "dnd-objective-5", //3
            "dnd-objective-1", //4
            "dnd-objective-4", //5
            "dnd-image-1", //6
            "dnd-winner-5", //7
            "dnd-image-5", //8
            "dnd-winner-2", //9
            "dnd-winner-3", //10
            "dnd-image-3", //11
            "dnd-winner-4", //12
            "dnd-winner-1" //13
        ])

        let spainGame = DragAndDropViewController()
        spainGame.gamePhaseModel = spainGamePhaseModel
        spainGame.customDelegate = customDelegate

        let unlockSpainStampView = UnlockedStampViewController(
            stampImage: "spain-selo",
            label: String(localized: "SpainUnlockStampTextLocalized"),
            sound: "SpainAddToAlbum",
            onFinishButtonPressed: nil
        )

        self.historyPages = [
            HistoryPageModel(
                image: "spain-1",
                text: String(localized: "SpainHistoryTextLocalized"),
                button: .next,
                audio: "SpainNarration1",
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-2",
                text: String(localized: "SpainHistoryTextLocalized2"),
                button: .next,
                audio: "SpainNarration2",
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-3",
                text: String(localized: "SpainHistoryTextLocalized3"),
                button: .next,
                audio: "SpainNarration3",
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-4",
                text: String(localized: "SpainHistoryTextLocalized4"),
                button: .finish,
                audio: "SpainNarration4",
                nextViewController: spainGame,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-5",
                text: String(localized: "SpainHistoryTextLocalized5"),
                button: .next,
                audio: "SpainNarration5",
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
