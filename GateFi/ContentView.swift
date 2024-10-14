//
//  ContentView.swift
//  GateFi
//
// Copyright (c) 2024 NetM
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack{
            VStack {
                Image(systemName: "bitcoinsign.circle.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                NavigationLink(destination: ConfigurationView()){
                    Text("Configuration")
                }
                
                NavigationLink(destination: QuotesView()){
                    Text("Quotes")
                }
                
                NavigationLink(destination: OrdersView()){
                    Text("Orders")
                }
                
                NavigationLink(destination: OrderView()){
                    Text("Order")
                }
                
            }
            .padding()
            
        }
        
        
    }
}

#Preview {
    ContentView()
}
