import Foundation

let europa: [CountryModel] = [
    CountryModel(name: "Inglaterra", background: "Fase1Selo")
]

let continents: [ContinentModel] = [
    ContinentModel(name: "Europa", countries: europa)
]

let pagesChapter1IntroView: [HistoryPageModel] = [
    HistoryPageModel(image: "OBJ1", text: textChapter1IntroView, button: .finish,
                     nextViewController: Chapter1GameViewController())
]

let chapter1IntroView = HistoryViewController(historyPages: pagesChapter1IntroView) {
    print("foi")
}

let textChapter1IntroView = "O que é isso? Onde estou? Eu me lembro desse lugar, mas algo está faltando! Preciso da sua ajuda para reconstruir essa memória"

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
        button: .finish,
        nextViewController: MenuViewController()
    )
]
