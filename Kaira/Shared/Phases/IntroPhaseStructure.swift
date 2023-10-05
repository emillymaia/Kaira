struct IntroPhaseStructure {
    // swiftlint: disable all
    let name = "Intro"

    var historyVC: [HistoryViewController] = []

    var texts: [String] = []

    var historyPages: [HistoryPageModel] = []

    init() {
        self.texts = [
            "Hi there, let's see where I start... my name is Kaira! So... I'd love to share more about my work, my daily routine (which is quite tiring), my hobbies... but I'm in the middle of a home move!",
            "Like many things in my life right now, the basement is a mess. The boxes seem to multiply every time I look. But wait...is that really what I'm thinking???",
            "My stamps! Oh God... how I loved that. How could I forget they exist?! Finally something happy in the middle of this mess...",
            "Oh, I've been looking for this letter for ages and it was right here! And that stamp?! The day I get it... Looking at it like this, I almost feel like I'm...",
            "THEEEEEREEEE!!!!!!!!! WHAAAAAT IS HAPPENNNNNING?"
        ]

        self.historyPages =  [
            HistoryPageModel(
                image: "intro-1",
                text: texts[0],
                button: .next
            ),
            HistoryPageModel(
                image: "intro-2",
                text: texts[1],
                button: .next
            ),
            HistoryPageModel(
                image: "intro-3",
                text: texts[2],
                button: .next
            ),
            HistoryPageModel(
                image: "intro-4",
                text: texts[3],
                button: .next
            ),
            HistoryPageModel(
                image: "intro-5",
                text: texts[4],
                button: .end,
                nextViewController: MenuViewController()
            )
        ]

        self.historyVC = [ HistoryViewController(historyPages: historyPages) {
            UserDefaultsManager.shared.didUserReceivedOnboarding = true
        }]
    }
}
