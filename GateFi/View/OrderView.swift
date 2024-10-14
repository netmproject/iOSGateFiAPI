//
//  OrderView.swift
//  GateFi
//
// Copyright (c) 2024 NetM
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
//
//

import SwiftUI

struct OrderView: View {
    var body: some View {
        VStack{
            Button {
                
                Task{
                    do{
                        let response = try await ApiNetworkOnRamp().getOrderStatus(orderId: "10632", walletAddress: "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa")
                        print(response)
                    }
                    catch{
                        print("Error in Configuration")
                        
                    }
                    
                }
                
                    } label: {
                        Text("Get Order")
                    }
        }
    }
}

#Preview {
    OrderView()
}
