struct SouthKoreaPhaseStructure: PhaseStructure {
    let name = "South Korea"
    var historyVC: [HistoryViewController] = []
    var historyPages: [HistoryPageModel] = []

    var customDelegate: DataDelegate?

    init(_ customDelegate: DataDelegate) {
        let southKoreaGamePhaseModel = GamePhaseModel(countryName: "South Korea", background: "", assets: [
            "south-korea-game-objective",
            "south-korea-game-winner",
            "south-korea-game-image-1",
            "south-korea-game-image-2",
            "south-korea-game-image-3",
            "south-korea-game-image-4",
            "south-korea-game-image-5",
        ])

        let southKoreaFindGame = FindImageViewController()
        southKoreaFindGame.gamePhaseModel = southKoreaGamePhaseModel
        southKoreaFindGame.customDelegate = customDelegate
        let unlockSouthKoreaStampView = UnlockedStampViewController(
            stampImage: "south-korea-selo",
            label: "South KOREA STAMP TEXT 1",
            sound: "SouthkoreaAddToAlbum",
            onFinishButtonPressed: nil
        )

        self.historyPages = [
            HistoryPageModel(
                image: "south-korea-1",
                text: "South KOREA TEXT 1",
                button: .next,
                audio: "SouthkoreaNarration1",
                skipViewController: southKoreaFindGame
            ),
            HistoryPageModel(
                image: "south-korea-2",
                text: "South KOREA TEXT 2",
                button: .finish,
                audio: "SouthkoreaNarration2",
                nextViewController: southKoreaFindGame,
                skipViewController: southKoreaFindGame
            ),
            HistoryPageModel(
                image: "south-korea-3",
                text: "South KOREA TEXT 3",
                button: .next,
                audio: "SouthkoreaNarration3",
                skipViewController: unlockSouthKoreaStampView
            ),
            HistoryPageModel(
                image: "south-korea-4",
                text: "South KOREA TEXT 4",
                button: .next,
                audio: "SouthkoreaNarration4",
                nextViewController: unlockSouthKoreaStampView,
                skipViewController: unlockSouthKoreaStampView
            )
        ]

        self.historyVC = [
            HistoryViewController(
                historyPages: [self.historyPages[0], self.historyPages[1]], onFinishButtonPressed: nil
            ),
            HistoryViewController(historyPages: [self.historyPages[2], self.historyPages[3]]) {
                    customDelegate.didUpdateData(data: 1)
            }
        ]

        southKoreaFindGame.historyViewController = self.historyVC[1]
    }
}
