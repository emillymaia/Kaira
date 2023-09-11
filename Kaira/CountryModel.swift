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
    CountryModel(name: "Brasil", background: "background"),
    CountryModel(name: "China", background: "background"),
    CountryModel(name: "Oii", background: "background")
]

let asia: [CountryModel] = [
    CountryModel(name: "EUA", background: "background"),
    CountryModel(name: "Flop", background: "background")
]

let america: [CountryModel] = [
    CountryModel(name: "Londres", background: "background"),
    CountryModel(name: "USA", background: "background")
]
