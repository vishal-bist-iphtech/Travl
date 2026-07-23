//
//  HourlyForecastCard.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI

struct HourlyForecastCard: View {

    let hourly: [HourlyWeather]

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("Hourly Forecast")
                .font(.title3.bold())

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 16) {

                    ForEach(hourly) { forecast in

                        VStack(spacing: 12) {

                            Text(forecast.time)
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Image(systemName: forecast.icon)
                                .font(.title2)
                                .symbolRenderingMode(.multicolor)

                            Text("\(forecast.temperature)°")
                                .font(.headline)
                        }
                        .frame(width: 70)
                        .padding(.vertical)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 18,
                                style: .continuous
                            )
                        )
                    }
                }
            }
        }
    }
}

#Preview {

    HourlyForecastCard(
        hourly: WeatherData.sample.hourly
    )
    .padding()
}
