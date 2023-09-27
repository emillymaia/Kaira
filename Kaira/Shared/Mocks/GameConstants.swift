import Foundation

let text = "The city was a labyrinth of concrete and steel" +
" place where people rushed from one place to another, never stopping to take a breath."

let onboardingPages: [HistoryPageModel] = [
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
        button: .end,
        nextViewController: MenuViewController()
    )
]

let mech1 = FindImageViewController()
let mech2 = SignatureViewController()
let mech3 = FindImageViewController()

let page0 = [
    HistoryPageModel(
        image: "OnboardingPage1",
        text: text + "1",
        button: .next,
        nextViewController: mech1
    )]

let page1 = [
    HistoryPageModel(
        image: "OnboardingPage1",
        text: text + "1",
        button: .next,
        nextViewController: mech2
    )]
let page2 = [
    HistoryPageModel(
        image: "OnboardingPage2",
        text: text + "1",
        button: .finish
    )]

let history0 = HistoryViewController(historyPages: page0, onFinishButtonPressed: nil)
let history1 = HistoryViewController(historyPages: page1, onFinishButtonPressed: nil)
let history2 = HistoryViewController(historyPages: page2, onFinishButtonPressed: nil)
