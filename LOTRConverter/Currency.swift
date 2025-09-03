//
//  Currency.swift
//  LOTRConverter
//
//  Created by Òscar Muntal on 1/9/25.
//

import SwiftUI

enum Currency: Double, CaseIterable, Identifiable, Codable {
    case copperPenny = 6400
    case copperPiece = 640
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    var id: Currency { self }
    
    var image: ImageResource {
        switch self {
        case .copperPenny:
            .copperpenny
        case .copperPiece:
            .copperpiece
        case .silverPenny:
            .silverpenny
        case .silverPiece:
            .silverpiece
        case .goldPenny:
            .goldpenny
        case .goldPiece:
            .goldpiece
        }
    }
    
    var name: String {
        switch self {
        case .copperPenny:
            "Copper Penny"
        case .copperPiece:
            "Copper Piece"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        }
    }
    
    func convert(_ amountString: String, to currency: Currency) -> String {
        guard let doubleAmount = Double(amountString) else {
            return ""
        }
        return String(format: "%.2f", (doubleAmount * currency.rawValue) / self.rawValue)
    }
}






















