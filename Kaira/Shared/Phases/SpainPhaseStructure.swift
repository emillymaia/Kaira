struct SpainPhaseStructure {
    // swiftlint: disable all

    let name = "Test"

    var historyVC: [HistoryViewController] = []

    var texts: [String] = []

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

        self.texts = [
            "Wait... Where am I? Why is everyone so loud? WHY AM I SO SMALL? Who’s with me?",
            "This place...I remember it. It feels like that day when...it's like I'm in a memory, but I'm not sure. Something is missing...Help me!!",
            "It is clear! Now I remember. The Big Ben! I visited England with my mother for the first time that day. But how did opening that box get me here? Why is this happening?",
            "Anyway, I need to get out of this situation, but it brings back so many good memories. I can still remember and see myself playing in the park with my mother."
        ]

        let unlockunlockSpainStampLabel = "Wow, I remember I won and sent a letter to my grandmother, I remember the breeze, the taste of my childhood."

        let unlockSpainStampView = UnlockedStampViewController(stampImage: "england-selo", label: unlockunlockSpainStampLabel, onFinishButtonPressed: nil)
        let spainGame = DragAndDropViewController()
        spainGame.gamePhaseModel = spainGamePhaseModel
        spainGame.customDelegate = customDelegate

        self.historyPages = [
            HistoryPageModel(
                image: "england-1",
                text: texts[0],
                button: .next,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "england-2",
                text: texts[1],
                button: .finish,
                nextViewController: spainGame,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "england-3",
                text: texts[2],
                button: .next,
                skipViewController: unlockSpainStampView
            ),
            HistoryPageModel(
                image: "england-4",
                text: texts[3],
                button: .next,
                nextViewController: unlockSpainStampView,
                skipViewController: unlockSpainStampView
            ),
        ]

        self.historyVC = [
            HistoryViewController(historyPages: [self.historyPages[0], self.historyPages[1]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[2], self.historyPages[3]]) {
                    print("Updater Called")
                    customDelegate.didUpdateData(data: 1)
            }
        ]

        spainGame.historyViewController = self.historyVC[1]
    }
}
