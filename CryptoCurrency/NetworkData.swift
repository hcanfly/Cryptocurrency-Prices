//
//  NetworkData.swift
//  CryptoCurrency
//
//  Created by Gary Hanson on 5/8/21.
//

import Foundation

// CoinMarketCap API Key. Basic plan is free
// https://pro.coinmarketcap.com/

// API Documentation
// https://coinmarketcap.com/api/documentation/v1/#section/Introduction


let APIKey = "<Your API Key goes here>"     // FIXME - your API Key goes here
let apikeyHeader = "X-CMC_PRO_API_KEY"
let baseURL = "https://pro-api.coinmarketcap.com/v1/"
let endpoint = "cryptocurrency/quotes/latest"



enum NetworkError: Error, LocalizedError {
    case invalidURL, invalidHTTPResponse, invalidServerResponse, jsonParsingError, apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidHTTPResponse:
            return "Invalid HTTP response"
        case .invalidServerResponse:
            return "Invalid service sesponse"
        case .jsonParsingError:
            return "Error parsing JSON"
        case .apiError(let reason):
            return reason
        }
    }
}

func getInfo(for id: CryptoId, completion: @escaping (Result<CryptoData, Error>) -> Void) {
    guard let url = URL(string: baseURL + endpoint + "?id=\(id.id())") else {
        completion(.failure(NetworkError.invalidURL))
        return
    }
//    get top 10 crypto currencies by market cap
//    guard let url = URL(string: baseURL + endpoint + "?limit=10") else {
//        completion(.failure(NetworkError.invalidURL))
//        return
//    }
    
    var request = URLRequest(url: url)
    request.setValue(APIKey, forHTTPHeaderField: apikeyHeader)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        if let error = error {
            print("Did you enter your API Key above?")
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            print("No data")
            return
        }
        
        do {
            //print(String(bytes: data, encoding: String.Encoding.utf8))
            let result = try JSONDecoder().decode(APIResponse.self, from: data)
            completion(.success(result.data.values.first!)) // really should only be one
        }
        catch {
            completion(.failure(error))
        }
        
    }
    task.resume()

}
