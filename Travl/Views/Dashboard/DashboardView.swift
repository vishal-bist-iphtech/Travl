//
//  DashboardView.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HeaderView()
                    
                    NextTripCard()
                    
                    HStack(spacing: 16) {
                        BudgetCard()
                        DaysCard()
                    }
                    
                    PackingProgressCard()
                    
                    TripCarousel()
                    MemoriesCarousel(memories: sampleMemories)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }        
    }
}

#Preview {
    DashboardView()
}
