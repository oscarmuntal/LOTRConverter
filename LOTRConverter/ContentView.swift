//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Òscar Muntal on 28/8/25.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    enum Field { case leftTyping, rightTyping }
    @FocusState private var focusedField: Field?
    
    let currencyTip = CurrencyTip()
    
    var body: some View {
        ZStack {
            //Background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                // Prancing pony image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Currency exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .padding()
                
                // Conversion section
                HStack {
                    // Left conversion section
                    VStack {
                        // Currency
                        HStack {
                            // Currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            // Currency text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .popoverTip(currencyTip, arrowEdge: .bottom)
                        
                        // Text field
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($focusedField, equals: .leftTyping)
                        
                    }
                    
                    // Equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    // Right conversion section
                    VStack {
                        // Currency
                        HStack {
                            // Currency text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            // Currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        
                        // Text field
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .rightTyping)
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                .keyboardType(.decimalPad)
                
                Spacer()
                
                // Info button
                HStack {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
            }
        }
        .onAppear {
            if let savedLeftCurrency = UserDefaults.standard.currency(forKey: "leftCurrency") {
                leftCurrency = savedLeftCurrency
            }
            if let savedRightCurrency = UserDefaults.standard.currency(forKey: "rightCurrency") {
                rightCurrency = savedRightCurrency
            }
        }
        .onTapGesture {
            focusedField = nil
        }
        .task {
            try? Tips.configure()
        }
        .onChange(of: leftAmount) { _, _ in
            if focusedField == .leftTyping {
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmount) { _, _ in
            if focusedField == .rightTyping {
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
            }
        }
        .onChange(of: leftCurrency) {
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency) {
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
        }
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
        }
    }
    
}

#Preview {
    ContentView()
}
