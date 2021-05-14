//
//  Model.swift
//  CryptoCurrency
//
//  Created by Gary Hanson on 5/8/21.
//

import UIKit


protocol DataAction: AnyObject {
    func dataChanged()
}


struct APIResponse: Codable {
    let data: [Int: CryptoData]
}

struct CryptoData: Codable, Hashable {
    let id: Int
    let name: String
    let symbol: String
    let quote: [String: Quote]
    
    func price() -> String {
        if let p = quote.first?.value.price {
            let p2 = NSNumber(value: p)
            return Self.currencyFormatter2.string(from: p2)!
        }
        
        return "0"
    }
    
    func percentChange() -> String {
        if let p = quote.first?.value.percent_change_24h {
            let p2 = NSNumber(value: p)
            let sign = p < 0.0 ? "" : "+"
            return sign + Self.numberFormatter.string(from: p2)! + "%"
        }
        
        return "0"
    }
    
    func volume() -> String {
        if let p = quote.first?.value.volume_24h {
            let volume = abbreviatedValue(p)
            let p2 = NSNumber(value: volume.value)
            return Self.currencyFormatter.string(from: p2)! + volume.label
        }
        
        return "0"
    }
    
    func marketCap() -> String {
        if let p = quote.first?.value.market_cap {
            let mc = abbreviatedValue(p)
            let p2 = NSNumber(value: mc.value)
            return Self.currencyFormatter.string(from: p2)! + mc.label
        }
        
        return "0"
    }
    
    func market_cap() -> Double {
        if let p = quote.first?.value.market_cap {
            return p
        }
        
        return 0
    }
    
    func percent_change() -> Float {
        if let p = quote.first?.value.percent_change_24h {
            return p
        }
        
        return 0
    }
    
    private func abbreviatedValue(_ value: Double) -> (value: Double, label: String) {
        
        if value > 1_000_000_000_000 {
            return (value / 1_000_000_000_000, "T")
        } else if value > 1_000_000_000 {
            return (value / 1_000_000_000, "B")
        }
        
        return (value, "")
    }
    
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 1
        formatter.locale = .current
        
        return formatter
    }()
    
    static let currencyFormatter2: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = .current
        
        return formatter
    }()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = .current
        
        return formatter
    }()
    
    static let prettyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter
    }()
    
    // ugly date/time conversion
    // https://stackoverflow.com/questions/60612749/iso8601dateformatter-not-converting-a-string-to-date
    static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds,
            .withColonSeparatorInTime,
            .withDashSeparatorInDate,
            .withTimeZone]
        formatter.timeZone = .current
        
        return formatter
    }()
}

struct Quote: Codable, Hashable {
    let price: Float
    let volume_24h: Double
    let percent_change_24h: Float
    let percent_change_7d: Float
    let percent_change_30d: Float
    let market_cap: Double
}

final class CryptoViewModel {
    static let shared = CryptoViewModel()
    
    var data: [CryptoData] = []
    weak var delegate: DataAction?

    private init() {
        
    }
    
    func loadData() {
        self.data.removeAll()
        
        //var counter = 0
        
        // limiting to the 10 cryptos defined. limiting because of daily cap on api calls.
        for id in CryptoId.allCases {
//            if counter > 2 {      // useful to restrict number of requests when making changes to UI repeatedly
//                continue
//            }
//            counter += 1
            getInfo(for: id) { result in
                switch result {
                case .success(let cryptoData):
                    self.data.append(cryptoData)
                    //if counter < 10 {
                    if self.data.count == CryptoId.allCases.count { // will be a definite problem if one of the currencies doesn't load
                        self.data = self.data.sorted(by: {$0.market_cap() > $1.market_cap()})
                        self.delegate?.dataChanged()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

}
