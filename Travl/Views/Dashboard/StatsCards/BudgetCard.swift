//
//  BudgetCard.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct BudgetCard: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: "dollarsign")
                .foregroundStyle(.blue)
                .frame(width:38, height: 38)
                .background(Color.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
//            Spacer()

                        Text("$2,257")
                            .font(.title)
                            .bold()

                        Text("budget remaining")
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth:.infinity)
                    .frame(height:150)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius:20))
    }
}


#Preview {
    BudgetCard()
}
