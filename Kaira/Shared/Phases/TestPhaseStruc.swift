struct TestPhaseStructure: PhaseStructure {
    // swiftlint: disable all

    let name = "England"

    var historyVC: [HistoryViewController] = []

    var texts: [String] = []

    var historyPages: [HistoryPageModel] = []

    var customDelegate: DataDelegate?

    init(_ customDelegate: DataDelegate) {
        let englandGamePhaseModel = GamePhaseModel(countryName: "England", background: "", assets: [ // interpolar string
            "england-game-objective",
            "mi-blue-image",
            "mi-blue-off",
            "mi-blue-on",
            "mi-green-image",
            "mi-green-off",
            "mi-green-on",
            "mi-orange-image",
            "mi-orange-off",
            "mi-orange-on",
            "mi-pink-image",
            "mi-pink-off",
            "mi-pink-on",
            "mi-purple-image",
            "mi-purple-off",
            "mi-purple-on",
            "mi-red-image",
            "mi-red-off",
            "mi-red-on",
        ])

        let _ = GamePhaseModel(countryName: "England", background: "", assets: [ // interpolar string
            "england-game-objective",
            "flag-background",
            "flag-1",
            "flag-2",
            "flag-3",
        ])

        self.texts = [ // passa pra um doc.
            "Wait... Where am I? Why is everyone so loud? WHY AM I SO SMALL? Who’s with me?",
            "This place...I remember it. It feels like that day when...it's like I'm in a memory, but I'm not sure. Something is missing...Help me!!",
            "It is clear! Now I remember. The Big Ben! I visited England with my mother for the first time that day. But how did opening that box get me here? Why is this happening?",
            "Anyway, I need to get out of this situation, but it brings back so many good memories. I can still remember and see myself playing in the park with my mother."
        ]

        let unlockunlockEnglandStampLabel = "Wow, I remember I won and sent a letter to my grandmother, I remember the breeze, the taste of my childhood."

        let unlockEnglandStampView = UnlockedStampViewController(stampImage: "england-selo", label: unlockunlockEnglandStampLabel, onFinishButtonPressed: nil)
        let englandFindGame = MatchImageViewController()
        englandFindGame.gamePhaseModel = englandGamePhaseModel
        englandFindGame.customDelegate = customDelegate

        self.historyPages = [
            HistoryPageModel(
                image: "england-1",
                text: texts[0],
                button: .next,
                skipViewController: englandFindGame
            ),
            HistoryPageModel(
                image: "england-2",
                text: texts[1],
                button: .finish,
                nextViewController: englandFindGame,
                skipViewController: englandFindGame
            ),
            HistoryPageModel(
                image: "england-3",
                text: texts[2],
                button: .next,
                skipViewController: unlockEnglandStampView
            ),
            HistoryPageModel(
                image: "england-4",
                text: texts[3],
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
