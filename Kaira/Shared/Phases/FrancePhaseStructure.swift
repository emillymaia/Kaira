struct FrancePhaseStructure {
    // swiftlint: disable all

    let name = "France"

    var historyVC: [HistoryViewController] = []

    var texts: [String] = []

    var historyPages: [HistoryPageModel] = []

    init(_ customDelegate: DataDelegate) {
        let franceSignGamePhaseModel = GamePhaseModel(countryName: "France", background: "france-game-2-background", assets: [
            "france-game-2-objective"
        ])

        let franceFindGamePhaseModel = GamePhaseModel(countryName: "France", background: "", assets: [
            "france-game-objective",
            "france-game-winner",
            "france-game-image-1",
            "france-game-image-2",
            "france-game-image-3",
        ])

        self.texts = [
            "And suddenly I'm on my first day of school in France??!?! I don't remember smiling like that. The things I experienced at that time... if I stopped here, I already know what comes next.",
            "When I changed schools, I didn't imagine I would feel so alone. No matter how much I worked on my accent, how nice I was...I couldn't belong to any group. But these things happen, right?",
            "In one of my attempts to find 'my place' in school, I remember making a decision that resulted in one of the best things I have today. Joining the book club!",
            "When I signed up so apprehensively, I had no idea that it would lead me to meet Chloé. She also didn't have many friends there, and when she saw my insecurity, she understood what I was feeling.",
            "Chloé is the best person I've ever met! Affectionate, sometimes annoying because she has like a hundred skills, talks really loudly, and always helps when someone is going through something... she doesn't know it, but she changed my life in so many ways.",
            "She took me to see the snow. She spent Christmases with my family in France. She is the person who welcomed me when I needed someone most. Damn, I have the best friend in the world."
            
        ]

        let unlockunlockFranceStampLabel = "On my 14th birthday, Chloé gave me a letter with this stamp. This is one of my favorite stamps, because Chloé and I loved eating croissants after school. I remember it like it was yesterday..."

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
                button: .next
            ),
            HistoryPageModel(
                image: "france-2",
                text: texts[1],
                button: .next
            ),
            HistoryPageModel(
                image: "france-3",
                text: texts[2],
                button: .next,
                nextViewController: franceSignGame
            ),
            HistoryPageModel(
                image: "france-4",
                text: texts[3],
                button: .next
            ),
            HistoryPageModel(
                image: "france-5",
                text: texts[4],
                button: .next,
                nextViewController: franceFindGame
            ),
            HistoryPageModel(
                image: "france-6",
                text: texts[5],
                button: .next,
                nextViewController: unlockFranceStampView
            )
        ]

        self.historyVC = [
            HistoryViewController(historyPages: [self.historyPages[0], self.historyPages[1], self.historyPages[2]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[3], self.historyPages[4]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[5]]) {
                    customDelegate.didUpdateData(data: 1)
            }
        ]

        franceSignGame.historyViewController = self.historyVC[1]
        franceFindGame.historyViewController = self.historyVC[2]
    }
}
