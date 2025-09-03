//
//  ConversionSection.swift
//  LOTRConverter
//
//  Created by Òscar Muntal on 3/9/25.
//

import SwiftUI
import TipKit

struct ConversionSection: View {
    @State var currencySide: CurrencySide
    @Binding var amount: String
    @Binding var currency: Currency
    @Binding var showSelectCurrency: Bool
    let currencyTip = CurrencyTip()
    let focusedField: FocusState<Field?>.Binding
    
    var body: some View {
        VStack {
            currencyImageName
            textField
        }
    }
}

private extension ConversionSection {
    var currencyImageName: some View {
        HStack {
            if currencySide == .left {
                currencyImage
                currencyName
            } else {
                currencyName
                currencyImage
            }
        }
        .padding(.bottom, -5)
        .onTapGesture {
            showSelectCurrency.toggle()
            currencyTip.invalidate(reason: .actionPerformed)
        }
        .popoverTip(currencyTip, arrowEdge: .bottom)
    }
    
    var currencyImage: some View {
        Image(currency.image)
            .resizable()
            .scaledToFit()
            .frame(height: 33)
    }
    
    var currencyName: some View {
        Text(currency.name)
            .font(.headline)
            .foregroundStyle(.white)
    }
    
    var textField: some View {
        TextField("Amount", text: $amount)
            .textFieldStyle(.roundedBorder)
            .focused(focusedField, equals: currencySide == .left ? .leftTyping : .rightTyping)
    }
}
