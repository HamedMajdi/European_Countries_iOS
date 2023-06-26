//
//  ContentView.swift
//  European Countries
//
//  Created by Hamed Majdi on 6/25/23.
//

import SwiftUI

struct AllDataView: View {
    
    @ObservedObject var countryListViewModel: CountryListViewModel
    @State private var searchedTerm = ""
    
    init(){
        self.countryListViewModel = CountryListViewModel()
    }
    
    var filteredCountries: [CountryViewModel]{
        guard !searchedTerm.isEmpty else {return countryListViewModel.countryList}
        return countryListViewModel.countryList.filter{$0.name.localizedCaseInsensitiveContains(searchedTerm)}
    }
        
    var body: some View {
        NavigationView{
            List(filteredCountries, id: \.id){ country in
                NavigationLink(destination: CountryDetailView(country: country), label: {
                    VStack(){
                        HStack{
                            AsyncImage(url: URL(string: country.flag)!) { image in
                                image.resizable().frame(width: 52, height: 52, alignment: .center)
                                    .cornerRadius(64)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(alignment: .leading)
                            } placeholder: {
                                ProgressView()
                            }

                            VStack{
                                Text(country.name)
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(EdgeInsets(top: 5, leading: 12, bottom: 0, trailing: 0))

                                Text(country.subRegion)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(EdgeInsets(top: 5, leading: 12, bottom: 10, trailing: 0))
                            }.frame(maxWidth: .infinity)
                        }

                        HStack{
                            HStack{
                                Image("capital")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .leading)
                                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 0))
                                Text(country.capital)
                                    .font(.system(size: 12, weight: .light))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }.frame(maxWidth: .infinity, alignment: .leading)

                            HStack{
                                Image("area")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .leading)
                                Text("\(country.area) km²")
                                    .font(.system(size: 12, weight: .light))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }.frame(maxWidth: .infinity)
                            
                            HStack{
                                Image("phone_code")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .leading)
                                Text(country.phone)
                                    .font(.system(size: 12, weight: .light))
                            }.frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }.frame(maxWidth: .infinity)
                            .padding(0)

                    }
                      .cornerRadius(8) // End of Vstack
                })

                
            }
            
        }.task{
            await countryListViewModel.downloadCountries(url: URL(string: "https://restcountries.com/v3.1/region/europe")!)
        }
        .searchable(text: $searchedTerm, prompt: "Search for the country...")
        
        
        .refreshable {
            Task.init{
                countryListViewModel.countryList = []
                await countryListViewModel.downloadCountries(url: URL(string: "https://restcountries.com/v3.1/region/europe")!)

            }
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            AllDataView()
        }
    }
    

}
