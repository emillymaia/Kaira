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
            label: "UNLOCK JAPAN SELO TEXT",
            onFinishButtonPressed: nil
        )

        self.historyPages = [
            HistoryPageModel(
                image: "japan-1",
                text: "JAPAN TEXT 1",
                button: .next,
                skipViewController: japanDnDGame
            ),
            HistoryPageModel(
                image: "japan-2",
                text: "JAPAN TEXT 2",
                button: .next,
                skipViewController: japanDnDGame
            ),
            HistoryPageModel(
                image: "japan-3",
                text: "JAPAN TEXT 3",
                button: .next,
                skipViewController: japanDnDGame
            ),
            HistoryPageModel(
                image: "japan-4",
                text: "JAPAN TEXT 4",
                button: .finish,
                nextViewController: japanDnDGame,
                skipViewController: japanDnDGame
            ),
            HistoryPageModel(
                image: "japan-5",
                text: "JAPAN TEXT 5",
                button: .next,
                nextViewController: japanFindGame,
                skipViewController: japanFindGame
            ),
            HistoryPageModel(
                image: "japan-6",
                text: "JAPAN TEXT 6",
                button: .next,
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
