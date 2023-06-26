//
//  ListViewModel.swift
//  European Countries
//
//  Created by Hamed Majdi on 6/25/23.
//

import Foundation

@MainActor
class CountryListViewModel: ObservableObject{
    
    @Published var countryList = [CountryViewModel]()
    let webService = WebService()
    
    func downloadCountries(url: URL) async{
        do {
            let countries = try await webService.downloadCountries(url: url)
            self.countryList = countries.map(CountryViewModel.init)
            
        } catch {
            print("ERROR FROM: \(error)")
        }
    }
    
}

struct CountryViewModel {
    let country: Country
    
    var id: UUID?{
        country.id
    }
    
    var name: String{
        country.countryName.finalName
    }
    
    var capital: String {
        country.capital[0]
    }
    
    var borders: [String]{
        country.borders ?? ["No Borders Found!"]
    }
    
    var flag: String{
        country.flag.finalPhoto
    }
    
    var phone: String{
        (country.phone.root + country.phone.suffix[0])
    }
    
    var area: Int{
        Int(country.area)
    }
    
    var population: Int{
        country.population
    }
    
    var subRegion: String{
        country.subRegion
    }
    
    var currency: [String]{
        
        getCurrenciesList(keys: Array(country.currency.keys))
    }
    
    var language: [String]{
        
        getLanguage(keys: Array(country.languages.keys))
    }
    
    
    func getCurrenciesList(keys: [String]) -> [String]{
        var currencies: [String] = []
    
        for currency in keys {
            currencies.append("\(currency)   (\(country.currency[currency]?.name ?? ""))")
        }
        
        return currencies
    
    }
    
    
    func getLanguage(keys: [String]) -> [String]{
        var languages: [String] = []
    
        for language in keys {
            languages.append("\(language)   (\(country.languages[language] ?? ""))")
        }
        
        return languages
    
    }
    
    var bordersOrdered: String{
        getOrderedLists(items: borders)
    }
    
    var languagesOrdered: String{
        getOrderedLists(items: language)

    }
    
    var currenciesOrdered: String{
        getOrderedLists(items: currency)

    }
    
    
    
    func getOrderedLists(items: [String]) -> String{
        var orderedList: String = ""
    
        for i in 0...items.count-1 {
            orderedList.append(items[i])
            
            if ((i - items.count) < -1){
                orderedList.append("\n")
            }
        }
        
        return orderedList
    
    }

}
