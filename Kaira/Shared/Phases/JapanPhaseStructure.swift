struct JapanPhaseStructure: PhaseStructure {
    // swiftlint: disable all
    let name = "Japan"
    var historyVC: [HistoryViewController] = []
    var historyPages: [HistoryPageModel] = []

    var customDelegate: DataDelegate?

    init(_ customDelegate: DataDelegate) {
        let japanGamePhaseModel2 = GamePhaseModel(countryName: "Japan", background: "", assets: [ // interpolar string
            "japan-game-objective",
            "japan-game-winner",
            "japan-game-image-1",
            "japan-game-image-2",
            "japan-game-image-3",
            "japan-game-image-4",
        ])

        let japanGamePhaseModel1 = GamePhaseModel(countryName: "Japan", background: "pause-background", assets: [
            "japan-game-2-objective",
            "japan-game-2-objective-image-1", //1
            "japan-game-2-objective-image-2", //2
            "japan-game-2-objective-image-3", //3
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

        let japanDnDGame = DragAndDropViewController()
        japanDnDGame.gamePhaseModel = japanGamePhaseModel1
        japanDnDGame.customDelegate = customDelegate

        let japanFindGame = FindImageViewController()
        japanFindGame.gamePhaseModel = japanGamePhaseModel2
        japanFindGame.customDelegate = customDelegate

        let unlockJapanStampView = UnlockedStampViewController(
            stampImage: "japan-selo",
            label: String(localized: "JapanUnlockStampTextLocalized"),
            sound: "JapanAddToAlbum",
            onFinishButtonPressed: nil
        )

        self.historyPages = [
            HistoryPageModel(
                image: "japan-1",
                text: String(localized: "JapanHistoryTextLocalized1"),
                button: .next,
                audio: "JapanNarration1",
                skipViewController: japanDnDGame
            ),
            HistoryPageModel(
                image: "japan-2",
                text: String(localized: "JapanHistoryTextLocalized2"),
                button: .next,
                audio: "JapanNarration2",
                skipViewController: japanDnDGame
            ),
            HistoryPageModel(
                image: "japan-3",
                text: String(localized: "JapanHistoryTextLocalized3"),
                button: .next,
                audio: "JapanNarration3",
                skipViewController: japanDnDGame
            ),
            HistoryPageModel(
                image: "japan-4",
                text: String(localized: "JapanHistoryTextLocalized4"),
                button: .finish,
                audio: "JapanNarration4",
                nextViewController: japanDnDGame,
                skipViewController: japanDnDGame
            ),
            HistoryPageModel(
                image: "japan-5",
                text: String(localized: "JapanHistoryTextLocalized5"),
                button: .next,
                audio: "JapanNarration5",
                nextViewController: japanFindGame,
                skipViewController: japanFindGame
            ),
            HistoryPageModel(
                image: "japan-6",
                text: String(localized: "JapanHistoryTextLocalized6"),
                button: .next,
                audio: "JapanNarration6",
                nextViewController: unlockJapanStampView,
                skipViewController: unlockJapanStampView
            ),
        ]

        self.historyVC = [
            HistoryViewController(historyPages: [self.historyPages[0], self.historyPages[1], self.historyPages[2], self.historyPages[3]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[4]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[5]]) {
                    customDelegate.didUpdateData(data: 1)
            }
        ]

        japanDnDGame.historyViewController = self.historyVC[1]
        japanFindGame.historyViewController = self.historyVC[2]
    }
}
