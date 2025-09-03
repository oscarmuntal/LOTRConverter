//
//  UserDefaults+Extension.swift
//  LOTRConverter
//
//  Created by Òscar Muntal on 3/9/25.
//

import Foundation

extension UserDefaults {
    func setCurrency(_ value: Currency, forKey key: String) {
        if let data = try? JSONEncoder().encode(value) {
            set(data, forKey: key)
        }
    }
    
    func currency(forKey key: String) -> Currency? {
        guard let data = data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(Currency.self, from: data)
    }
}
