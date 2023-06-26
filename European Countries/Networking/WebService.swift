//
//  WebService.swift
//  European Countries
//
//  Created by Hamed Majdi on 6/25/23.
//

import Foundation

class WebService{
    
    func downloadCountries(url: URL) async throws -> [Country]{
        let (data, _) = try await URLSession.shared.data(from: url)

        let countries = try? JSONDecoder().decode([Country].self, from: data)
        return countries ?? []
    }
    
}
