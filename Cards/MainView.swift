//
//  MainView.swift
//  Cards
//
//  Created by Balla Tamás on 2022. 06. 18..
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var dataController = DataController.instance
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Főoldal", systemImage: "list.dash")
                }
            
            AddPackView()
                .tabItem {
                    Label("Paklik", systemImage: "square.and.pencil")
                }.environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
