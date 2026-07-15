//
//  PackingProgressCard.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct PackingProgressCard: View {

    let progress = 0.71

    var body: some View {

        VStack(alignment:.leading,spacing:16){

            HStack{

                Text("Packing Progress")
                    .bold()

                Spacer()

                Text("71%")
                    .bold()
                    .foregroundStyle(.blue)
            }

            ProgressView(value: progress)

            Text("15 of 21 items ready")
                .foregroundStyle(.gray)
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius:20))
    }
}

#Preview {
    PackingProgressCard()
}
