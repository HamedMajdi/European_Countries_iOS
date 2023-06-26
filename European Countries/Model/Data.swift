//
//  Data.swift
//  European Countries
//
//  Created by Hamed Majdi on 6/25/23.
//

import Foundation

struct Country: Codable, Identifiable {
    let id = UUID()
    let countryName: Name
    let capital: [String]
    let borders: [String]?
    let flag: Flag
    let phone: NumberCode
    let area: Double
    let population: Int
    let subRegion: String
    let currency: [String: Currencies]
    let languages: [String: String]
    
    private enum CodingKeys: String, CodingKey{
        case countryName = "name"
        case capital = "capital"
        case borders = "borders"
        case flag = "flags"
        case phone = "idd"
        case area = "area"
        case population = "population"
        case subRegion = "subregion"
        case currency = "currencies"
        case languages = "languages"
    }
}

struct Currencies: Codable {
    let name: String
    
    private enum CodingKeys: String, CodingKey{
        case name = "name"
    }
}

struct Name: Codable {
    let finalName: String
    private enum CodingKeys: String, CodingKey{
        case finalName = "common"
    }
}

struct Flag: Codable {
    let finalPhoto: String
    
    private enum CodingKeys: String, CodingKey{
        case finalPhoto = "png"
    }

}

struct NumberCode: Codable {
    let root: String
    let suffix: [String]
    
    private enum CodingKeys: String, CodingKey{
        case root = "root"
        case suffix = "suffixes"
    }
}
