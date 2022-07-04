//
//  Pack.swift
//  Cards
//
//  Created by Balla Tamás on 2022. 06. 17..
//

import Foundation

struct Pack : Identifiable {
    let id = UUID()
    let name: String
    let cards: [CardViewModel]
}
