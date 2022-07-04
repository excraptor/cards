//
//  AddPackView.swift
//  Cards
//
//  Created by Balla Tamás on 2022. 06. 17..
//

import SwiftUI
import CoreData

struct AddPackView: View {
    
    @State private var isLinkActive: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
        
    @FetchRequest(entity: PackEntity.entity(), sortDescriptors: [])
    private var packs: FetchedResults<PackEntity>
    
    @FetchRequest(entity: CardEntity.entity(), sortDescriptors: [])
    private var cards: FetchedResults<CardEntity>
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    List(packs) { pack in
                        NavigationLink(destination: PackView(cards: cards.filter { card in
                            card.packName == pack.packName
                        })) {
                            Text(pack.packName!)
                        }
                    }
                    NavigationLink(destination: CreateCardsView(), label: {
                        Text("Új pakli")
                    })
                }
            }
            
            
        }
        
    }
}

//@State private var selection = Identifiable.ID

struct AddPackView_Previews: PreviewProvider {
    static var previews: some View {
        AddPackView()
    }
}
