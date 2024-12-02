//
//  ContentView.swift
//  Memorize
//
//  Created by Adelaide Jia on 2024/11/27.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var buttonColor
    
    @State var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚒"]
    
    let fruits = ["🥝", "🍈", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓"]
    let animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🐻", "🐼", "🐨", "🐯"]
    let vehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚒"]
    
    @State var cardCount = 8
    
    var body: some View {
        VStack {
            title
            ScrollView { cards }
            Spacer()
            //cardCountAdjusters
            themeButton
            
        }
        .padding()
    }
    var title: some View {
        Text("Memorize!").font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            let reatedEmojis = Array(repeating: emojis, count: 2).flatMap {$0}.shuffled()
            ForEach(0..<reatedEmojis.count, id: \.self) { index in
                CardView(content: reatedEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardCountAdjuster(by: -1, symbol: "minus.rectangle.fill")
            Spacer()
            cardCountAdjuster(by: 1, symbol: "plus.rectangle.fill")
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var themeButton: some View {
        HStack(alignment: .bottom, spacing: 45) {
            changeTheme(theme: vehicles, themeName: "Vehicles", symbol: "car.rear")
            changeTheme(theme: animals, themeName: "Animals", symbol: "fish")
            changeTheme(theme: fruits, themeName: "Fruits", symbol: "carrot")
        }
        .foregroundColor(buttonColor == .dark ? .white : .blue)
        .font(.system(size: 30))
    }
    
    func changeTheme(theme: [String] , themeName: String, symbol: String) -> some View{
        Button(action: {
            emojis = theme.shuffled()
        }, label: {
            VStack {
                Image(systemName: symbol)
                Text(themeName).font(.system(size: 12))
            }
        })
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    let base = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
