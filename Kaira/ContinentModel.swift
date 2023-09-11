import Foundation

class ContinentModel {
    var name: String
    var countries: [CountryModel]

    init(name: String, countries: [CountryModel]) {
        self.name = name
        self.countries = countries
    }
}
