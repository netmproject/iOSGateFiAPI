//
//  ApiNetworkOnRamp.swift
//  GateFi
//
// Copyright (c) 2024 NetM
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
//

import Foundation

class ApiNetworkOnRamp{
    
    //OnRamp
    
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
        let buy: Buy
        let orderTracking: OrderTracking
        let orderAnalytics: OrderAnalytic
        let sell: String?
      
    }
    
    struct Quote:Codable{
        let enabled: Bool
    }
    
    struct Buy:Codable{
        let enabled: Bool
        let authentication: Authentication
        let redirectOrderId: [String]
        let orderCustomId: Bool
        let browser: String
        let userAgent: String
        
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
        let min: String
        let max: String
    }
    
    struct Crypto:Codable{
        let id: String
        let address: String
        let network: String
        let paymentLimits: [PaymentLimit]
    }
    
    struct QuoteResponse:Codable{
        let processingFee: String
        let networkFee: String
        let amountOut: String
    }
    
    struct OrderStatusResponse:Codable{
        let id: String
        let customId: String
        let link: String
        let crypto: Crypto
        let fiatAmountInUsd: String
        let fiat: String
        let payment: String
        let providerPayment: String
        let cryptoAmountOut: String
        let fiatAmountIn: String
        let exchangeRate: String
        let processingFees: [ProcessingFee]
        let networkFees: [NetworkFee]
        let partnerFees: [PartnerFee]
        let createdAt: String
        let updatedAt: String
        let transactionHash: String
        let walletAddress: String
        let status: String
        let statusCode: String
        let statusReason: String
        let partnerAccountId: String
        let orderType: String
    }
    
    struct ProcessingFee:Codable{
        let label: String
        let fiatAmount: String
    }
    
    struct NetworkFee:Codable{
        let label: String
        let fiatAmount: String
    }
    
    struct PartnerFee:Codable{
        let label: String
        let fiatAmount: String
    }
    
    struct OrderListResponse:Codable{
        let orders: [OrderStatusResponse]
    }
    
    struct BuyResponse:Codable{
        
    }
    
    
    func getConfiguration() async throws -> ConfigurationResponse{
        let url = URL(string: "https://api-sandbox.gatefi.com/onramp/v1/configuration")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("123", forHTTPHeaderField: "api-key")
        request.setValue("2b6b6c58d175ec6bd13c92a17d262fce9336fe1bb41fc1bae0753927c0bbcf2d", forHTTPHeaderField: "signature")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let configuration = try JSONDecoder().decode(ConfigurationResponse.self, from: data)
        
        return configuration
    }
    
    func getQuotes(amount: String, crypto: String, fiat: String, partnerAccountId: String,
                   payment: String, region: String) async throws -> QuoteResponse{
        
        let baseURL = URL(string: "https://api-sandbox.gatefi.com/onramp/v1/quotes")!
        let parameter1 = URLQueryItem(name: "amount", value: amount)
        let parameter2 = URLQueryItem(name: "crypto", value: crypto)
        let parameter3 = URLQueryItem(name: "fiat", value: fiat)
        let parameter4 = URLQueryItem(name: "partnerAccountId", value: partnerAccountId)
        let parameter5 = URLQueryItem(name: "payment", value: payment)
        let parameter6 = URLQueryItem(name: "region", value: region)
        
        let url = baseURL.appending(queryItems: [
            parameter1,
            parameter2,
            parameter3,
            parameter4,
            parameter5,
            parameter6
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
    
    func getOrderStatus(orderId: String, walletAddress: String) async throws -> OrderStatusResponse{
        let baseURL = URL(string: "https://api-sandbox.gatefi.com/onramp/v1/orders/\(orderId)")!
        let parameter = URLQueryItem(name: "walletAddress", value: walletAddress)
        
        let url = baseURL.appending(queryItems: [
            parameter
        ])
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("123", forHTTPHeaderField: "api-key")
        request.setValue("2b6b6c58d175ec6bd13c92a17d262fce9336fe1bb41fc1bae0753927c0bbcf2d", forHTTPHeaderField: "signature")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let order = try JSONDecoder().decode(OrderStatusResponse.self, from: data)
        
        return order
    }
    
    func getOrderList(end: String, limit: String,
                      skip: String, start: String) async throws -> OrderListResponse{
        let baseURL = URL(string: "https://api-sandbox.gatefi.com/onramp/v1/orders")!
        let parameter1 = URLQueryItem(name: "end", value: end)
        let parameter2 = URLQueryItem(name: "limit", value: limit)
        let parameter3 = URLQueryItem(name: "skip", value: skip)
        let parameter4 = URLQueryItem(name: "start", value: start)
        
        let url = baseURL.appending(queryItems: [
            parameter1,
            parameter2,
            parameter3,
            parameter4
        ])
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("123", forHTTPHeaderField: "api-key")
        request.setValue("2b6b6c58d175ec6bd13c92a17d262fce9336fe1bb41fc1bae0753927c0bbcf2d", forHTTPHeaderField: "signature")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let list = try JSONDecoder().decode(OrderListResponse.self, from: data)
        
        return list
    }
    
    func getBuy(cancelUrl: String, declineUrl: String, amount: String,
                crypto: String, fiat: String, orderCustomId: String,
                partnerAccountId: String, payment: String, redirectUrl: String,
                region: String, walletAddress: String) async throws -> BuyResponse{
        let baseURL = URL(string: "https://api-sandbox.gatefi.com/onramp/v1/buy")!
        let parameter1 = URLQueryItem(name: "cancelUrl", value: cancelUrl)
        let parameter2 = URLQueryItem(name: "declineUrl", value: declineUrl)
        let parameter3 = URLQueryItem(name: "amount", value: amount)
        let parameter4 = URLQueryItem(name: "crypto", value: crypto)
        let parameter5 = URLQueryItem(name: "fiat", value: fiat)
        let parameter6 = URLQueryItem(name: "orderCustomId", value: orderCustomId)
        let parameter7 = URLQueryItem(name: "partnerAccountId", value: partnerAccountId)
        let parameter8 = URLQueryItem(name: "payment", value: payment)
        let parameter9 = URLQueryItem(name: "redirectUrl", value: redirectUrl)
        let parameter10 = URLQueryItem(name: "region", value: region)
        let parameter11 = URLQueryItem(name: "walletAddress", value: walletAddress)
        
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
        ])
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("123", forHTTPHeaderField: "api-key")
        request.setValue("2b6b6c58d175ec6bd13c92a17d262fce9336fe1bb41fc1bae0753927c0bbcf2d", forHTTPHeaderField: "signature")
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let buy = try JSONDecoder().decode(BuyResponse.self, from: data)
        
        return buy
    }
    
}


