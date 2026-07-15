//
//  Memory.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//
import Foundation

struct Memory: Identifiable {

    let id = UUID()

    let title: String

    let imageName: String

    let isFavorite: Bool
}


let sampleMemories = [

    Memory(
        title: "Goa Sunset",
        imageName: "memory1",
        isFavorite: true
    ),

    Memory(
        title: "Bali Swim",
        imageName: "memory2",
        isFavorite: false
    ),

    Memory(
        title: "Red Beach",
        imageName: "memory3",
        isFavorite: true
    )
]
