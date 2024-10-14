//
//  QuotesView.swift
//  GateFi
//
// Copyright (c) 2024 NetM
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
//
//

import SwiftUI

struct QuotesView: View {
    var body: some View {
        VStack{
            Button {
                
                Task{
                    do{
                        let response = try await ApiNetworkOnRamp().getQuotes(amount: "100", crypto: "BTC", fiat: "USD", partnerAccountId: "testID", payment: "APPLEPAY", region: "US")
                        print(response)
                    }
                    catch{
                        print("Error in Configuration")
                        
                    }
                    
                }
                
                    } label: {
                        Text("Get Quotes")
                    }
        }
    }
}

#Preview {
    QuotesView()
}
