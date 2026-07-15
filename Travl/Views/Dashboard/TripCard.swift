//
//  TripCard.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct TripCard: View {

    var body: some View {

        VStack(alignment:.leading){

            Image("goa")
                .resizable()
                .scaledToFill()
                .frame(width:130,height:110)
                .clipped()

            VStack(alignment:.leading){

                Text("Goa")
                    .bold()

                Text("India")
                    .foregroundStyle(.gray)
            }
            .padding(8)
        }
        .frame(width:130)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius:18))
    }
}

#Preview {
    TripCard()
}
