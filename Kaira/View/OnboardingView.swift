import UIKit

var text = "The city was a labyrinth of concrete and steel" +
" place where people rushed from one place to another, never stopping to take a breath."

var onboardingPages: [HistoryPageModel] = [
    HistoryPageModel(
        image: "OnboardingPage1",
        text: text + "1",
        button: .next
    ),
    HistoryPageModel(
        image: "OnboardingPage2",
        text: text + "2",
        button: .next
    ),
    HistoryPageModel(
        image: "OnboardingPage3",
        text: text + "3",
        button: .next
    ),
    HistoryPageModel(
        image: "OnboardingPage4",
        text: text + "3",
        button: .finish,
        nextViewController: MenuViewController()
    )
]

var onboardingView = HistoryViewController(historyPages: onboardingPages) {
    UserDefaultsManager.shared.didUserReceivedOnboarding = true
}
