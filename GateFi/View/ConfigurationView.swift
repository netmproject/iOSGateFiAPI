//
//  ConfigurationView.swift
//  GateFi
//
// Copyright (c) 2024 NetM
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
//

import SwiftUI

struct ConfigurationView: View {
    @State private var text: String = ""
    var body: some View {
        
            VStack{
                Button {
                    
                    Task{
                        do{
                            let response = try await ApiNetworkOnRamp().getConfiguration()
                            print(response)
                        }
                        catch{
                            print("Error in Configuration")
                            
                        }
                        
                    }
                    
                        } label: {
                            Text("Get Configuration")
                        }
            }
        }
}

#Preview {
    ConfigurationView()
}
