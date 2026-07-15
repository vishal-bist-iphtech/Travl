//
//  HeaderView.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct HeaderView: View {
    
    var body: some View {
        
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Good Morning")
                    .foregroundStyle(.secondary)
                
                Text("Vishal Bisht")
                    .font(.largeTitle)
                    .bold()
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                Button {
                    
                } label: {
                    Image(systemName: "bell.fill")
                        .font(.title)
                        .padding(4)
                        .background(.ultraThinMaterial, in: Circle())
                        .clipShape(Circle())
                        .shadow(radius: 1)
                        
                }
                Button {
                    
                } label: {
                    Text("VB")
                        .font(.title)
                        .bold()
                        .padding(6)
                        .background(.ultraThinMaterial, in: Circle())
                        .clipShape(Circle())
                        .shadow(radius: 1)
                        
                }
            }
        }
    }
}

#Preview {
    HeaderView()
}
