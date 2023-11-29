struct IntroPhaseStructure {
    // swiftlint: disable all
    let name = "Intro"
    var historyVC: [HistoryViewController] = []
    var historyPages: [HistoryPageModel] = []

    init() {
        UserDefaultsManager.shared.isBackgroundSoundOn = true
        self.historyPages =  [
            HistoryPageModel(
                image: "intro-1",
                text: String(localized: "IntroHistoryTextLocalized1"),
                button: .next,
                audio: "IntroNarration1"
            ),
            HistoryPageModel(
                image: "intro-2",
                text: String(localized: "IntroHistoryTextLocalized2"),
                button: .next,
                audio: "IntroNarration2"
            ),
            HistoryPageModel(
                image: "intro-3",
                text: String(localized: "IntroHistoryTextLocalized3"),
                button: .next,
                audio: "IntroNarration3"
            ),
            HistoryPageModel(
                image: "intro-4",
                text: String(localized: "IntroHistoryTextLocalized4"),
                button: .next,
                audio: "IntroNarration4"
            ),
            HistoryPageModel(
                image: "intro-5",
                text: String(localized: "IntroHistoryTextLocalized5"),
                button: .end,
                audio: "IntroNarration5",
                nextViewController: MenuViewController()
            )
        ]

        self.historyVC = [ HistoryViewController(historyPages: historyPages) {
            UserDefaultsManager.shared.didUserReceivedOnboarding = true
        }]
    }
}
