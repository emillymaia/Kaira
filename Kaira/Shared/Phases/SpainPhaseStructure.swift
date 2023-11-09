struct SpainPhaseStructure: PhaseStructure {
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
            String(localized:"Okay, now back to 17?!?! At that time, my family decided to spend their holidays in Spain. We stayed in Barcelona for 3 months, and it was a time of great maturity for me."),
            String(localized:"In Barcelona, I decided to get a part-time job, to try to save some money. It was my first time doing a job interview, and I was really nervous. It gave me a strange feeling of butterflies in my stomach...but in a bad way."),
            String(localized:"Even though I felt insecure during the interview, I ended up being hired. I remember that, when I received the news, I was radiant, glowing with happiness. My first job was a big achievement for me..."),
            String(localized:"The job I got was as an assistant in a bakery. Decorate cakes, put empanadas in the oven,  serve customers, organize shelves... Even though it was a lot of work, I loved everyday life at the bakery."),
            String(localized:"Getting my first job made me learn how to handle my money. Even though the salary wasn't that high, I started saving money for my next trips. Every time I put in a coin, I imagined myself traveling around...")
        ]

        let unlockunlockSpainStampLabel = String(localized:"I bought this stamp at El Prat Airport, when I was leaving Barcelona. I loved Spain and everything it gave me. To this day, Barcelona is one of my favorite places in the whole world!")

        let unlockSpainStampView = UnlockedStampViewController(stampImage: "spain-selo", label: unlockunlockSpainStampLabel, onFinishButtonPressed: nil)
        let spainGame = DragAndDropViewController()
        spainGame.gamePhaseModel = spainGamePhaseModel
        spainGame.customDelegate = customDelegate

        self.historyPages = [
            HistoryPageModel(
                image: "spain-1",
                text: texts[0],
                button: .next,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-2",
                text: texts[1],
                button: .next,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-3",
                text: texts[2],
                button: .next,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-4",
                text: texts[3],
                button: .finish,
                nextViewController: spainGame,
                skipViewController: spainGame
            ),
            HistoryPageModel(
                image: "spain-5",
                text: texts[4],
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
