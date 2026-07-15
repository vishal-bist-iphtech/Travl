//
//  DaysCard.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct DaysCard: View {

    var body: some View {

        VStack(alignment:.leading,spacing:16){

            Image(systemName:"calendar")
                .foregroundStyle(.orange)
                .frame(width:38,height:38)
                .background(Color.orange.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius:10))

//            Spacer()

            Text("26")
                .font(.title)
                .bold()

            Text("days until departure")
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
    DaysCard()
}
