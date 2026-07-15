//
//  TripCarousel.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct TripCarousel: View {

    var body: some View {

        VStack(alignment:.leading){

            HStack{

                Text("All Trips")
                    .font(.title3)
                    .bold()

                Spacer()

                Button("See all"){

                }
            }

            ScrollView(.horizontal,showsIndicators:false){

                HStack(spacing:16){

                    TripCard()

                    TripCard()

                    TripCard()
                }
            }
        }
    }
}

#Preview {
    TripCarousel()
}
