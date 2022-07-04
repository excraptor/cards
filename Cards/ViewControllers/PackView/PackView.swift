//
//  PackView.swift
//  Cards
//
//  Created by Balla Tamás on 2022. 06. 18..
//

import SwiftUI


enum LearnedState {
    case learned
    case learning
    case dontKnow
}

struct PackView: View {
    
    @State var cards: [CardEntity]
    @State private var cardsLearnedState: Dictionary<UUID?, LearnedState>
    @State private var currentIndex = 0
    @State private var currentCards: [CardEntity]
    
    init(cards input: [CardEntity]) {
        self.cards = input
        self.currentCards = input
        self.cardsLearnedState = Dictionary(uniqueKeysWithValues: input.lazy.map { card in
            (card.id!, .learning)
        })
    }
    
    var body: some View {
        VStack {
            if currentIndex < currentCards.count {
                let card: CardEntity = currentCards[currentIndex]
                CardView(card: card)

                HStack {
                    Button("Tudom") {
                        let id = currentCards[currentIndex].id
                        cardsLearnedState[id] = .learned
                        currentIndex+=1
                        print("tudom")
                    }.background(.green)

                    Button("Nem tudom") {
                        let id = currentCards[currentIndex].id
                        cardsLearnedState[id] = .dontKnow
                        currentIndex+=1
                    }.background(.red)
                }
            } else {
                VStack {
                    Text("Végignéztél mindent!")
                    Spacer()
                    if cardsLearnedState.filter {(key, value) in value == .dontKnow || value == .learning }.count != 0 {
                        Button("Nem megtanultak újrakeverése") {
                            cardsLearnedState.forEach { (id, state) in
                                if state == .dontKnow {
                                    currentCards = cards.filter { card in
                                        cardsLearnedState[card.id] == .dontKnow
                                    }
                                }
                            }
                            currentIndex = 0
                        }
                    } else {
                        Button("Újrakezdés") {
                            currentCards = cards
                            currentIndex = 0
                            self.cardsLearnedState = Dictionary(uniqueKeysWithValues: currentCards.lazy.map { card in
                                (card.id, .learning)
                            })
                        }
                    }
                }
                
            
            }
        }
        
    }
}

struct PackView_Previews: PreviewProvider {
    static var previews: some View {
        PackView(cards: [])
    }
}
