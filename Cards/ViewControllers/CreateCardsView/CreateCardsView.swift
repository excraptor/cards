//
//  CreateCardsView.swift
//  Cards
//
//  Created by Balla Tamás on 2022. 06. 21..
//

import SwiftUI
import CoreData

struct CreateCardsView: View {
    
    @State private var title: String = ""
    @State private var solution: UIImage = UIImage()
    @State private var packName: String = ""
    @State private var isPackNameEditable: Bool = true
    @State private var showingSheet = false
    @Environment (\.managedObjectContext) private var viewContext
    @FetchRequest(entity: CardEntity.entity(), sortDescriptors: [])
    private var cards: FetchedResults<CardEntity>
    
    @FetchRequest(entity: PackEntity.entity(), sortDescriptors: [])
    private var packs: FetchedResults<PackEntity>
    
    var body: some View {
        VStack {
            if isPackNameEditable {
                TextField("A pakli neve: ", text: $packName).padding(20)
                
                Button("Mentés") {
                    isPackNameEditable = false
                    savePackName()
                }
            }
            else {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(.white)
                        .shadow(color: .black, radius: 10.0)
                    
                    VStack {
                        TextField("A vegyület neve", text: $title).padding(20)
                        
                        HStack {
                            Text("Megoldás")
                            Image(uiImage: self.solution)
                                          .resizable()
                                          .frame(width: 250, height: 250, alignment: .leading)
                                          .background(Color.black.opacity(0.2))
                                          .aspectRatio(contentMode: .fill)
                                          .onTapGesture {
                                                showingSheet = true
                                          }
                        }.sheet(isPresented: $showingSheet) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$solution)
                                
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 140))
                        
                        Button("Hozzáadás") {
                            saveCard()
                        }
                    }
                }.frame(width: 500.0, height: 500.0, alignment: .leading)
                    .padding(20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
    }
    
    private func savePackName() {
        let pack = PackEntity(context: viewContext)
        pack.id = UUID()
        pack.packName = packName
        
        saveContext()
    }
    
    private func saveCard() {
        let card = CardEntity(context: viewContext)
        card.id = UUID()
        card.title = title
        card.image = solution.pngData()
        card.packName = packName
        
        saveContext()
    }
    
    private func saveContext() {
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("An error occured: \(error)")
            }
        }
}

struct CreateCardsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCardsView()
    }
}
