//
//  CardsApp.swift
//  Cards
//
//  Created by Balla Tamás on 2022. 06. 17..
//

import SwiftUI

@main
struct CardsApp: App {
    
    @StateObject private var dataController = DataController.instance
    
    var body: some Scene {
        WindowGroup {
            MainView().environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
