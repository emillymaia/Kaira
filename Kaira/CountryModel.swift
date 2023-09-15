import Foundation

class CountryModel {
    let name: String
    var background: String

    init(name: String, background: String) {
        self.name = name
        self.background = background
    }
}

let europa: [CountryModel] = [
    CountryModel(name: "Inglaterra", background: "Fase1Selo")
]
