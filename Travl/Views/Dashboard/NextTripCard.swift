//
//  NextTripCard.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct NextTripCard: View {
    
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            
            Image("goa")
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipped()
            
            LinearGradient(
                colors: [.clear, .black.opacity(0.75)],
                startPoint: .center,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("NEXT TRIP")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.white.opacity(0.3))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    Text("26d away")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal,12)
                        .padding(.vertical, 6)
                        .background(.orange)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
                Spacer()
                
                Text("Goa, India")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                
                Label("Goa . Aug 10, 2026 - Aug 18, 2026", systemImage: "location")
                    .foregroundStyle(.white.opacity(0.9))
                    .font(.subheadline)
            }
            .padding()
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}


#Preview {
    NextTripCard()
}
