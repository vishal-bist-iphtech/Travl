//
//  SplashView.swift
//  Travl
//
//  Created by iPHTech 34 on 17/07/26.
//

import SwiftUI

struct SplashView: View {

    @State private var animate = false

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color.blue,
                    Color.cyan
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {

                Image(systemName: "airplane.circle.fill")
                    .font(.system(size: 90))
                    .foregroundStyle(.white)
                    .scaleEffect(animate ? 1 : 0.9)
                    .opacity(animate ? 1 : 0.6)

                VStack(spacing: 8) {

                    Text("Travl")
                        .font(.system(size: 42, weight: .bold))

                    Text("Plan • Explore • Remember")
                        .font(.headline)
                        .opacity(0.9)
                }
                .foregroundStyle(.white)
            }
        }
        .onAppear {

            withAnimation(
                .easeInOut(duration: 1)
                .repeatForever(autoreverses: true)
            ) {
                animate = true
            }
        }
    }
}

#Preview {
    SplashView()
}
