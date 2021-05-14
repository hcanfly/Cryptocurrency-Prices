//
//  CryptoCurrencies.swift
//  CryptoCurrency
//
//  Created by Gary Hanson on 5/9/21.
//

import Foundation


// list of crypto currencies
// curl -H "X-CMC_PRO_API_KEY:  114748ba-f82c-414f-802e-4390127ae7fa" -H "Accept: application/json" -d "start=1&limit=100&convert=USD" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest

// top 10 crypto currencies by market value as of 9 May 2021
enum CryptoId: CaseIterable {
    case Bitcoin
    case Ethereum
    case BinanceCoin
    case Dogecoin
    case Cardano
    case Tether
    case XRP
    case Polkadot
    case BitcoinCash
    case Litecoin
    
    func id() -> Int {
        switch self {
        case .Bitcoin:
            return 1
        case .Ethereum:
            return 1027
        case .BinanceCoin:
            return 1839
        case .Dogecoin:
            return 74
        case .Cardano:
            return 2010
        case .Tether:
            return 825
        case .XRP:
            return 52
        case .Polkadot:
            return 6636
        case .BitcoinCash:
            return 1831
        case .Litecoin:
            return 2
        }
    }
    
    func symbol() -> String {
        switch self {
        case .Bitcoin:
            return "BTC"
        case .Ethereum:
            return "ETH"
        case .BinanceCoin:
            return "BNB"
        case .Dogecoin:
            return "DOGE"
        case .Cardano:
            return "ADA"
        case .Tether:
            return "USDT"
        case .XRP:
            return "XRP"
        case .Polkadot:
            return "DOT"
        case .BitcoinCash:
            return "BCH"
        case .Litecoin:
            return "LTC"
        }
    }
}
