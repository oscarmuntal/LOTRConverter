//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Òscar Muntal on 28/8/25.
//

import SwiftUI
import TipKit

public enum Field { case leftTyping, rightTyping }

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    @FocusState private var focusedField: Field?
        
    var body: some View {
        ZStack {
            background
            VStack {
                prancingPonyImage
                currencyExchangeTitle
                conversionSection
                Spacer()
                infoButton
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

// MARK: - Top Views
private extension ContentView {
    var background: some View {
        Image(.background)
            .resizable()
            .ignoresSafeArea()
    }
    
    var prancingPonyImage: some View {
        Image(.prancingpony)
            .resizable()
            .scaledToFit()
            .frame(height: 200)
    }
    
    var currencyExchangeTitle: some View {
        Text("Currency Exchange")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .padding()
    }
    
    var conversionSection: some View {
        HStack {
            leftConversionSection
            equalSign
            rightConversionSection
        }
        .padding()
        .background(.black.opacity(0.5))
        .clipShape(.capsule)
        .keyboardType(.decimalPad)
    }
    
    var infoButton: some View {
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

// MARK: - Sub Views
private extension ContentView {
    var leftConversionSection: some View {
        ConversionSection(currencySide: .left, amount: $leftAmount, currency: $leftCurrency, showSelectCurrency: $showSelectCurrency, focusedField: $focusedField)
    }
    
    var equalSign: some View {
        Image(systemName: "equal")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .symbolEffect(.pulse)
    }
    
    var rightConversionSection: some View {
        ConversionSection(currencySide: .right, amount: $rightAmount, currency: $rightCurrency, showSelectCurrency: $showSelectCurrency, focusedField: $focusedField)
    }
}

#Preview {
    ContentView()
}
