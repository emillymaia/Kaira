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
            "What, why am I here again? Anyway, I remember that this was my first time at school in France, my mother traveled a lot so it was common to live in new schools, and I loved it! I can even remember what will happen to me...",
            "Nobody wants to be my friend? I don't know if it was a language barrier, but I remember going home sad because I wasn't part of the groups. I was so upset, we don't always fit in where we want.",
            "How many posters... certainly some of them interest me, let me see...  How many posters... certainly some of them interest me, let me see... The book club! Yes! I loved it!",
            "This was the first time I met Chloé, she was my best friend. In the book club she had the same tastes as me, I loved discussing novels with her. She was also from another city, which is why we got along so well.",
            "Lorem ipsum dolor sit amet",
        ]

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
                button: .next,
                nextViewController: franceFindGame
            ),
            HistoryPageModel(
                image: "france-5",
                text: texts[4],
                button: .finish
            )
        ]

        self.historyVC = [
            HistoryViewController(historyPages: [self.historyPages[0], self.historyPages[1], self.historyPages[2]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[3]], onFinishButtonPressed: nil),
            HistoryViewController(historyPages: [self.historyPages[4]]) {
                    customDelegate.didUpdateData(data: 1)
            }
        ]

        franceSignGame.historyViewController = self.historyVC[1]
        franceFindGame.historyViewController = self.historyVC[2]
    }
}
