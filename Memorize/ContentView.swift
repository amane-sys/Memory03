////
////  ContentView.swift
////  Memorize
////
////  Created by Adelaide Jia on 2024/11/27.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @Environment(\.colorScheme) var buttonColor
//    
//    @State var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚒"]
//    
//    let fruits = ["🥝", "🍈", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓"]
//    let animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🐻", "🐼", "🐨", "🐯"]
//    let vehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚒"]
//    
//    @State var cardCount = 8
//    
//    var body: some View {
//        VStack {
//            ScrollView { cards }
//            Spacer()
//            //cardCountAdjusters
//            //themeButton
//            
//        }
//        .padding()
//    }
//    
//    var cards: some View {
//        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
//            let repeatedEmojis = Array(repeating: emojis, count: 2).flatMap {$0}.shuffled()
//            ForEach(0..<repeatedEmojis.count, id: \.self) { index in
//                CardView(content: repeatedEmojis[index])
//                    .aspectRatio(2/3, contentMode: .fit)
//            }
//        }.foregroundColor(.orange)
//    }
//    // add or delate cards
//    var cardCountAdjusters: some View {
//        HStack {
//            cardCountAdjuster(by: -1, symbol: "minus.rectangle.fill")
//            Spacer()
//            cardCountAdjuster(by: 1, symbol: "plus.rectangle.fill")
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
//    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//    // change the theme
//    var themeButton: some View {
//        HStack(alignment: .bottom, spacing: 45) {
//            // to do ....
//            changeTheme(theme: vehicles, themeName: "Vehicles", symbol: "car.rear")
//            changeTheme(theme: animals, themeName: "Animals", symbol: "fish")
//            changeTheme(theme: fruits, themeName: "Fruits", symbol: "carrot")
//        }
//        .foregroundColor(buttonColor == .dark ? .white : .blue)
//        .font(.system(size: 30))
//    }
//    
//    func changeTheme(theme: [String] , themeName: String, symbol: String) -> some View{
//        Button(action: {
//            emojis = theme.shuffled()
//        }, label: {
//            VStack {
//                Image(systemName: symbol)
//                Text(themeName).font(.system(size: 12))
//            }
//        })
//    }
//}
