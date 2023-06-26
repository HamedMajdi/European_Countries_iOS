//
//  CountryDetailView.swift
//  European Countries
//
//  Created by Hamed Majdi on 6/26/23.
//

import SwiftUI

struct CountryDetailView: View {
    
    var country: CountryViewModel
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: country.flag)!) { image in
                    image.resizable()
                        .cornerRadius(20)
                        .aspectRatio(contentMode: .fill)
                        .frame(alignment: .leading)
                        .padding(12)
                        .shadow(radius: 12)
                } placeholder: {
                    ProgressView()
                }
                
                VStack{
                    Text("\(country.name) is a European country located in \(country.subRegion). It has a population of \(country.population) people and covers an area of \(country.area) km². The capital of \(country.name) is \(country.capital), and the official language spoken is \(country.language[0]).")
                                        .font(.system(size: 20))
                                        .lineSpacing(6)
                                        .padding(6)
                                        .background(Color("TextBox_Background_Color"))
                                        .cornerRadius(4)
                                        .shadow(radius: 4)
                }
                .padding(6)
                VStack{
                    DetailsRow(icon: "ic_name", title: "Name:", value: country.name, colorHolder: "name_holder", colorSelected: "name_selected")
                    
                    DetailsRow(icon: "ic_capital", title: "Capital:", value: country.capital, colorHolder: "capital_holder", colorSelected: "capital_selected")
                    
                    DetailsRow(icon: "ic_phone", title: "Phone:", value: country.phone, colorHolder: "phone_holder", colorSelected: "phone_selected")
                    
                    DetailsRow(icon: "ic_area", title: "Area:", value: "\(country.area)", colorHolder: "area_holder", colorSelected: "area_selected")
                    
                    DetailsRow(icon: "ic_population", title: "Population:", value: "\(country.population)", colorHolder: "population_holder", colorSelected: "population_selected")
                    
                    DetailsRow(icon: "ic_subregion", title: "Subregion:", value: country.subRegion, colorHolder: "subregion_holder", colorSelected: "subregion_selected")
                    
                    DetailsRow(icon: "ic_currency", title: "Currency:", value: country.currenciesOrdered, colorHolder: "currency_holder", colorSelected: "currency_selected")
    
                    DetailsRow(icon: "ic_languagee", title: "Language:", value: country.languagesOrdered, colorHolder: "language_holder", colorSelected: "language_selected")
    
                    DetailsRow(icon: "ic_borders", title: "Borders:", value: country.bordersOrdered, colorHolder: "border_holder", colorSelected: "border_selected")
                }
            }
        }
        
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(country: CountryListViewModel().countryList[0])


    }
}


struct DetailsRow: View {
    let icon: String
    let title: String
    let value: String
    let colorHolder: String
    let colorSelected: String

    var body: some View {
        HStack {
            
            Image(icon)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 16, trailing: 12))
        
            
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .light))
                .padding(.trailing, 16)
                .foregroundColor(Color(colorHolder))
                
            
            Text(value)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(colorHolder))

        }
        .padding(.vertical, 8)
    }
}

