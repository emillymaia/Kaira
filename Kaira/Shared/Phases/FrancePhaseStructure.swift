struct FrancePhaseStructure: PhaseStructure {
    // swiftlint: disable all

    let name = "France"

    var historyVC: [HistoryViewController] = []

    var texts: [String] = []

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
            "\(name.lowercased())-game-image-3",
        ])

        self.texts = [
            String(localized: "And suddenly I'm on my first day of school in France??!?! I don't remember smiling like that. The things I experienced at that time... if I stopped here, I already know what comes next."),
            String(localized: "When I changed schools, I didn't imagine I would feel so alone. No matter how much I worked on my accent or tried to be cool... I couldn't belong to any group. But these things happen, right?"),
            String(localized: "In one of my attempts to find 'my place' in school, I remember making a decision that resulted in one of the best things I have today. Joining the book club!"),
            String(localized: "When I signed up so apprehensively, I had no idea that it would lead me to meet Chloé. She also didn't have many friends there, and when she saw how insecure I was, she understood what I was feeling."),
            String(localized: "Chloé is the best person I've ever met! So sweet, very annoying because she has a hundred skills and always helps when someone needs it... she doesn't know it, but she changed my life in so many ways."),
            String(localized: "She took me to see the snow. She spent Christmases with my family in France. She is the person who welcomed me when I needed someone the most. Damn, I have the best friend in the world.")
            
        ]

        let unlockunlockFranceStampLabel = String(localized:"On my 14th birthday, Chloé gave me a letter with this stamp. This is one of my favorite stamps, because Chloé and I loved eating croissants after school. I remember it like it was yesterday...")

        let unlockFranceStampView = UnlockedStampViewController(stampImage: "france-selo", label: unlockunlockFranceStampLabel, onFinishButtonPressed: nil)
        let franceSignGame = SignatureViewController()
        franceSignGame.gamePhaseModel = franceSignGamePhaseModel
        franceSignGame.customDelegate = customDelegate

        let franceFindGame = FindImageViewController()
        franceFindGame.gamePhaseModel = franceFindGamePhaseModel
        franceFindGame.customDelegate = customDelegate

        self.historyPages = [
            HistoryPageModel(
                image: "france-1",
                text: texts[0],
                button: .next,
                skipViewController: franceSignGame
            ),
            HistoryPageModel(
                image: "france-2",
                text: texts[1],
                button: .next,
                skipViewController: franceSignGame
            ),
            HistoryPageModel(
                image: "france-3",
                text: texts[2],
                button: .finish,
                nextViewController: franceSignGame,
                skipViewController: franceSignGame
            ),
            HistoryPageModel(
                image: "france-4",
                text: texts[3],
                button: .next,
                skipViewController: franceFindGame
            ),
            HistoryPageModel(
                image: "france-5",
                text: texts[4],
                button: .finish,
                nextViewController: franceFindGame,
                skipViewController: franceFindGame
            ),
            HistoryPageModel(
                image: "france-6",
                text: texts[5],
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
