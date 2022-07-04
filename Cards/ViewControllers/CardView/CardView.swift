//
//  CardView.swift
//  Cards
//
//  Created by Balla Tamás on 2022. 06. 19..
//

import SwiftUI

struct Line {
    var points = [CGPoint]()
    var color: Color = .black
    var lineWidth: Double = 1.0
}

struct CardView: View {
    
    let card: CardEntity
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var currentColor: Color = .black
    @State private var isShowingAnswer: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .fill(.white)
                .shadow(color: .black, radius: 10.0)
            
            VStack {
                Text(card.title!)
                
                Canvas { context, size in
                    
                    for line in lines {
                        var path = Path()
                        path.addLines(line.points)
                        context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                    }
                    
                    
                }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in
                        let newPoint = value.location
                        currentLine.points.append(newPoint)
                        lines.append(currentLine)
                    }
                    .onEnded { value in
                        currentLine = Line(points: [], color: currentColor)
                    }
                )
                
                ColorPicker("Színválasztó", selection: $currentColor)
                    .onChange(of: currentColor, perform: { [] cr in
                        currentLine.color = cr
                    })
                
                Button("Mutasd a megoldást") {
                    withAnimation {
                        isShowingAnswer.toggle()
                    }
                    
                }.padding(10.0)
                
                if isShowingAnswer {
                    Image(uiImage: UIImage(data: card.image!)!)
                        .resizable()
                        .transition(.move(edge: .bottom))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300, alignment: .center)
                }
                
            }.multilineTextAlignment(.center).padding(20.0)
            
            
        }.frame(width: UIScreen.main.bounds.width-70.0, height: 500.0, alignment: .center)
    }
}


