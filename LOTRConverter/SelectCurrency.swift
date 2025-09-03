//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by Òscar Muntal on 1/9/25.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency
    
    var body: some View {
        ZStack {
            // Background
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                // Text
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                
                // Currency icons
                IconGrid(currencySide: "leftCurrency", selectedCurrency: $topCurrency)
                
                
                // Text
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                    .padding(.top)
                
                // Currency icons
                IconGrid(currencySide: "rightCurrency", selectedCurrency: $bottomCurrency)
                
                // Done button
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    @Previewable @State var topCurrency: Currency = .silverPenny
    @Previewable @State var bottomCurrency: Currency = .goldPenny
    
    VStack {
        SelectCurrency(topCurrency: $topCurrency, bottomCurrency: $bottomCurrency)
    }
}


