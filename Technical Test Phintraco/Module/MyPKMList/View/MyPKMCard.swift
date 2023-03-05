//
//  MyPKMCard.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 04/03/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyPKMCard: View {
    let myPokemon: MyPKMModel
    let bgColor: Color
    var body: some View {
        ZStack {
            bgColor
                .cornerRadius(UIScreen.pkmCornerRadius)
            HStack(spacing: UIScreen.viewPadding) {
                WebImage(url: URL(string: myPokemon.imgURL))
                    .resizable()
                    .scaledToFit()
                VStack(alignment: .leading) {
                    Text("\(myPokemon.name) - \(myPokemon.fibonancci)")
                        .font(.custom(FontManager.Poppins.bold, size: 18))
                        .foregroundColor(.white)
                        .lineLimit(2)
                    Text(Helper.idFormatter(id: myPokemon.id))
                        .font(.custom(FontManager.Poppins.regule, size: 12))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
        }
        .frame(height: UIScreen.screenWidth/4)
    }
}

// struct MyPKMCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPKMCard(myPokemon: <#MyPKMModel#>)
//    }
// }
