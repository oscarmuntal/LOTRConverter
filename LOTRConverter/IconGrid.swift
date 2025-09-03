//
//  IconGrid.swift
//  LOTRConverter
//
//  Created by Òscar Muntal on 2/9/25.
//

import SwiftUI

struct IconGrid: View {
    var currencySide: String
    @Binding var selectedCurrency: Currency
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(Currency.allCases) { currency in
                if selectedCurrency == currency {
                    CurrencyIcon(currencyImage: currency.image, currencyName: currency.name)
                        .shadow(color: .black, radius: 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 3)
                                .opacity(0.5)
                        }
                } else {
                    CurrencyIcon(currencyImage: currency.image, currencyName: currency.name)
                        .onTapGesture {
                            selectedCurrency = currency
                            UserDefaults.standard.setCurrency(currency, forKey: currencySide)
                            //"leftCurrency"
                        }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedCurrency: Currency = .goldPenny
    
    VStack {
        IconGrid(currencySide: "leftCurrency", selectedCurrency: $selectedCurrency)
    }
}


