//
//  ApiNetworkOffRamp.swift
//  GateFi
//
// Copyright (c) 2024 NetM
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
//


import Foundation

class ApiNetworkOffRamp{
    
    //OffRamp
    
    struct ConfigurationResponse:Codable{
        let version: String
        let updatedAt: String
        let features: Feature
        let countries: [Country]
        let payments: [Payment]
        let fiat: [Fiat]
        let crypto: [Crypto]
        
    }
    
    struct Feature:Codable{
        let quotes: Quote
        let buy: String?
        let orderTracking: OrderTracking
        let orderAnalytics: OrderAnalytic
        let sell: Sell
      
    }
    
    struct Quote:Codable{
        let enabled: Bool
    }
    
    struct Sell:Codable{
        let enabled: Bool
        let authentication: Authentication
        let orderCustomId: Bool
    }
    
    struct Authentication:Codable{
        let scheme: String
        let apiKey: ApiKey
        
        enum CodingKeys: String, CodingKey{
            case scheme = "scheme"
            case apiKey = "api-key"
        }
    }
    
    struct ApiKey:Codable{
        let locationType: String
        let location: String
    }
    
    struct OrderTracking:Codable{
        let enabled: Bool
    }
    
    struct OrderAnalytic:Codable{
        let enabled: Bool
    }
    
    struct Country:Codable{
        let id: String
        let states: String?
        
    }
    
    struct Payment:Codable{
        let id: String
        let availableFiatCurrencies: [String]
        let availableCountries: [String]
    }
    
    struct Fiat:Codable{
        let id: String
        let paymentLimits: [PaymentLimit]
    }
    
    struct PaymentLimit:Codable{
        let id: String
        let currency: String
        let min: String
        let max: String
        let minCrypto: String
        let maxCrypto: String
    }
    
    struct Crypto:Codable{
        let id: String
        let address: String
        let network: String
        let paymentLimits: [PaymentLimit]
    }
    
    struct QuoteResponse:Codable{
        let processingFee: String
        let amountOut: String
        let amountIn: String
        let exchangeRate: String
    }
    
    struct OrderStatusResponse:Codable{
        let id: String
        let customId: String
        let userId: String
        let link: String
        let crypto: Crypto
        let cryptoAmountIn: String
        let cryptoAmountInFiat: String
        let fiat: String
        let fiatAmountOut: String
        let exchangeRate: String
        let processingFees: [ProcessingFee]
        let partnerFees: [PartnerFee]
        let createdAt: String
        let updatedAt: String
        let unlimitWalletAddress: String
        let userWalletAddress: String
        let status: String
        let partnerAccountId: String
        let orderType: String
        let feesInUsd: FeesInUsd
    }
    
    struct ProcessingFee:Codable{
        let label: String
        let fiatAmount: String
    }
    
    struct PartnerFee:Codable{
        let label: String
        let fiatAmount: String
    }
    
    struct FeesInUsd:Codable{
        let processingFees: String
        let partnerFees: String
    }
    
    struct SellResponse:Codable{
        
    }
    
    
    func getConfiguration() async throws -> ConfigurationResponse{
        let url = URL(string: "https://api-sandbox.gatefi.com/offramp/v1/configuration")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("123", forHTTPHeaderField: "api-key")
        request.setValue("2b6b6c58d175ec6bd13c92a17d262fce9336fe1bb41fc1bae0753927c0bbcf2d", forHTTPHeaderField: "signature")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let configuration = try JSONDecoder().decode(ConfigurationResponse.self, from: data)
        
        return configuration
    }
    
    func getQuotes(CFCacheStatus: String, CFRAY: String,
                   CacheControl: String, Connection: String,
                   ContentEncoding: String, ContentType: String,
                   Date: String, NEL: String,
                   ReportTo: String, Server: String,
                   TransferEncoding: String, altsvc: String,
                   expires: String, pragma: String,
                   strictTransportSecurity: String, vary: String,
                   xRequestId: String) async throws -> QuoteResponse{
        let baseURL = URL(string: "https://api-sandbox.gatefi.com/offramp/v1/quotes")!
        let parameter1 = URLQueryItem(name: "CF-Cache-Status", value: CFCacheStatus)
        let parameter2 = URLQueryItem(name: "CF-RAY", value: CFRAY)
        let parameter3 = URLQueryItem(name: "Cache-Control", value: CacheControl)
        let parameter4 = URLQueryItem(name: "Connection", value: Connection)
        let parameter5 = URLQueryItem(name: "Content-Encoding", value: ContentEncoding)
        let parameter6 = URLQueryItem(name: "Content-Type", value: ContentType)
        let parameter7 = URLQueryItem(name: "Date", value: Date)
        let parameter8 = URLQueryItem(name: "NEL", value: NEL)
        let parameter9 = URLQueryItem(name: "Report-To", value: ReportTo)
        let parameter10 = URLQueryItem(name: "Server", value: Server)
        let parameter11 = URLQueryItem(name: "Transfer-Encoding", value: TransferEncoding)
        let parameter12 = URLQueryItem(name: "alt-svc", value: altsvc)
        let parameter13 = URLQueryItem(name: "expires", value: expires)
        let parameter14 = URLQueryItem(name: "pragma", value: pragma)
        let parameter15 = URLQueryItem(name: "strict-transport-security", value: strictTransportSecurity)
        let parameter16 = URLQueryItem(name: "vary", value: vary)
        let parameter17 = URLQueryItem(name: "x-request-id", value: xRequestId)
        
        let url = baseURL.appending(queryItems: [
            parameter1,
            parameter2,
            parameter3,
            parameter4,
            parameter5,
            parameter6,
            parameter7,
            parameter8,
            parameter9,
            parameter10,
            parameter11,
            parameter12,
            parameter13,
            parameter14,
            parameter15,
            parameter16,
            parameter17
        ])
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("123", forHTTPHeaderField: "api-key")
        request.setValue("2b6b6c58d175ec6bd13c92a17d262fce9336fe1bb41fc1bae0753927c0bbcf2d", forHTTPHeaderField: "signature")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let quotes = try JSONDecoder().decode(QuoteResponse.self, from: data)
        
        return quotes
    }
    
    func getOrderStatus(orderId: String) async throws -> OrderStatusResponse{
        let url = URL(string: "https://api-sandbox.gatefi.com/offramp/v1/orders/\(orderId)")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("123", forHTTPHeaderField: "api-key")
        request.setValue("2b6b6c58d175ec6bd13c92a17d262fce9336fe1bb41fc1bae0753927c0bbcf2d", forHTTPHeaderField: "signature")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let order = try JSONDecoder().decode(OrderStatusResponse.self, from: data)
        
        return order
    }
    
    func getSell(amount: Double, crypto: String,
                 fiat: String, orderCustomId: String,
                 partnerAccountId: String, payment: String,
                 region: String) async throws -> SellResponse{
        let baseURL = URL(string: "https://api-sandbox.gatefi.com/offramp/v1/sell")!
        let parameter1 = URLQueryItem(name: "amount", value: String(amount))
        let parameter2 = URLQueryItem(name: "crypto", value: crypto)
        let parameter3 = URLQueryItem(name: "fiat", value: fiat)
        let parameter4 = URLQueryItem(name: "orderCustomId", value: orderCustomId)
        let parameter5 = URLQueryItem(name: "partnerAccountId", value: partnerAccountId)
        let parameter6 = URLQueryItem(name: "payment", value: payment)
        let parameter7 = URLQueryItem(name: "region", value: region)
        
        let url = baseURL.appending(queryItems: [
            parameter1,
            parameter2,
            parameter3,
            parameter4,
            parameter5,
            parameter6,
            parameter7
        ])
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("123", forHTTPHeaderField: "api-key")
        request.setValue("2b6b6c58d175ec6bd13c92a17d262fce9336fe1bb41fc1bae0753927c0bbcf2d", forHTTPHeaderField: "signature")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let sell = try JSONDecoder().decode(SellResponse.self, from: data)
        
        return sell
    }
    
}


