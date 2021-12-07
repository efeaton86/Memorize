//
//  ContentView.swift
//  Memorize_e
//
//  Created by Eric Eaton on 12/2/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var activeTheme:String! = "themeAnimal"
    
    var themeDictionary = [
        "themeVehicle": ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "🚢",],
        "themeAnimal": ["🦆", "🦅", "🐴", "🦄", "🐝", "🐛", "🦋", "🦜", "🦢", "🐌", "🐞", "🐜","🦞", "🕊", "🐳", "🦒","🐓", "🦨", "🦦", "🦃"],
        "themeFood": ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🥥", "🍍", "🍑", "🍒", "🥑","🥬", "🥕", "🫒"]
    ]
   
    
    var body: some View {
        //main stack vertical on phone
        VStack{
            //HStack for App label
            HStack {
                Text("Memorize!").font(.largeTitle).foregroundColor(.purple)
            }
            
            //vertical stack -> scrollview -> lazyVgrid for cards
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                        ForEach(viewModel.model.cards) {
                            card in CardView(card: card).onTapGesture {
                                viewModel.choose(card)
                            }.aspectRatio(2/3, contentMode: .fit)
                        }.foregroundColor(.purple)
                    }
                }
            }.padding(.horizontal)
            Spacer()
            
            //horizontal stack for themeselction
            HStack{
                animalThemeButton
                Spacer()
                foodThemeButton
                Spacer()
                vehicleThemeButton
            }.padding()
        }
    }
    
    var animalThemeButton: some View {
        Button(
            action: {activeTheme = "themeAnimal"}, label: {
                VStack {
                    Text("🦜").font(.largeTitle)
                    Text("Animals")
                }
            }
        )
    }
    
    var foodThemeButton: some View {
        Button(
            action: {activeTheme = "themeFood"},
            label: {
                VStack {
                    Text("🍓").font(.largeTitle)
                    Text("Food")
                }
            }
        )
    }

    var vehicleThemeButton: some View {
        Button(
            action: {activeTheme = "themeVehicle"},
            label: {
                VStack {
                    Text("🚘").font(.largeTitle)
                    Text("Vehicles")}
                }
            )
        }
    }

    
//how the card will be rendered on the UI
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 15.0)  //card base
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }
            else if card.matched
            {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
    }
}






















































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            ContentView(viewModel: game)
                .previewInterfaceOrientation(.portrait)
            ContentView(viewModel: game)
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.portrait)
        }
    }

}
