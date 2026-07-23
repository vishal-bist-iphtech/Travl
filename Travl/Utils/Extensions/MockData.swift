//
//  MockData.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

extension WeatherData {

    static let sample = WeatherData(

        city: "Manali",

        temperature: 24,

        condition: "Sunny",

        icon: "sun.max.fill",

        feelsLike: 26,

        humidity: 48,

        windSpeed: 12,

        rainChance: 10,

        uvIndex: 7,

        hourly: [

            HourlyWeather(
                time: "10 AM",
                icon: "sun.max.fill",
                temperature: 24
            ),

            HourlyWeather(
                time: "12 PM",
                icon: "sun.max.fill",
                temperature: 26
            ),

            HourlyWeather(
                time: "2 PM",
                icon: "cloud.sun.fill",
                temperature: 27
            ),

            HourlyWeather(
                time: "4 PM",
                icon: "cloud.fill",
                temperature: 25
            ),

            HourlyWeather(
                time: "6 PM",
                icon: "cloud.moon.fill",
                temperature: 22
            )
        ],

        weekly: [

            DailyWeather(
                day: "Mon",
                icon: "sun.max.fill",
                high: 28,
                low: 18
            ),

            DailyWeather(
                day: "Tue",
                icon: "cloud.sun.fill",
                high: 27,
                low: 18
            ),

            DailyWeather(
                day: "Wed",
                icon: "cloud.rain.fill",
                high: 24,
                low: 17
            ),

            DailyWeather(
                day: "Thu",
                icon: "sun.max.fill",
                high: 27,
                low: 19
            ),

            DailyWeather(
                day: "Fri",
                icon: "cloud.fill",
                high: 25,
                low: 18
            ),

            DailyWeather(
                day: "Sat",
                icon: "cloud.sun.fill",
                high: 26,
                low: 17
            ),

            DailyWeather(
                day: "Sun",
                icon: "cloud.rain.fill",
                high: 23,
                low: 16
            )
        ]
    )
}
