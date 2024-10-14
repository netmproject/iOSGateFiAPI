//
//  OrdersView.swift
//  GateFi
//
// Copyright (c) 2024 NetM
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
//
//

import SwiftUI

struct OrdersView: View {
    var body: some View {
        VStack{
            Button {
                
                Task{
                    do{
                        let response = try await ApiNetworkOnRamp().getOrderList(end: "10/16/2024", limit: "1000", skip: "0", start: "10/10/2024")
                        print(response)
                    }
                    catch{
                        print("Error in Configuration")
                        
                    }
                    
                }
                
                    } label: {
                        Text("Get Orders")
                    }
        }
    }
}

#Preview {
    OrdersView()
}
