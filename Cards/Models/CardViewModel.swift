//
//  Card.swift
//  Cards
//
//  Created by Balla Tamás on 2022. 06. 17..
//

import Foundation
import SwiftUI

struct CardViewModel : Identifiable {
    let id = UUID()
    let title: String
    let solution: NSData
    let packName: String
    
    
    //static let example: Card = Card(title: "Metán", solution: "CH4")
}
