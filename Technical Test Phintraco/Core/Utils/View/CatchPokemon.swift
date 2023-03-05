//
//  CatchPokemon.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 04/03/23.
//

import SwiftUI

struct CatchPokemon: View {
    
    @State private var scale: CGFloat = 1.0
    @State private var animate: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button {
            animate = true
            scale = 1.2
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring()) {
                    scale = 1.0
                }
                animate = false
                action()
            }
        } label: {
            Image(uiImage: UIImage(named: "PokeballCatch") ?? UIImage())
                .resizable()
                .frame(width: UIScreen.screenWidth/6, height: UIScreen.screenWidth/6)
                .padding(20)
                .scaleEffect(scale)
                .rotationEffect(animate ? .degrees(360) : .degrees(0))
        }
    }
}

struct CatchPokemon_Previews: PreviewProvider {
    static var previews: some View {
        CatchPokemon(action: {})
    }
}
