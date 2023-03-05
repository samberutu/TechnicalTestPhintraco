//
//  PKMCard.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PKMCard: View {
    
    @ObservedObject var presenter: PKMDetailPresenter
    var itemIdx: Int
    var itemName: String
    var action: (() -> Void)
    @State private var pkmCardModel: PKMCardModel?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: UIScreen.pkmCornerRadius, style: .continuous)
                .stroke(presenter.typeColor, lineWidth: 1.5)
            if let pkmCardData = pkmCardModel {
                VStack {
                    HStack {
                        Spacer()
                        Text(presenter.pkmIdFormat(pkmId: itemIdx))
                            .multilineTextAlignment(.trailing)
                            .font(.custom(FontManager.Poppins.bold, size: 12))
                            .foregroundColor(presenter.getTypeColor())
                    }
                    .padding(.trailing, UIScreen.viewPadding/2)
                    .padding(.top, UIScreen.viewPadding/2)
                    WebImage(url: URL(string: pkmCardData.imgUrl))
                        .resizable()
                        .placeholder(content: {
                            Image(uiImage: UIImage(named: "example") ?? UIImage())
                                .resizable()
                                .scaledToFit()
                        })
                        .scaledToFit()
                    ZStack {
                        presenter.getTypeColor()
                            .cornerRadius(UIScreen.pkmCornerRadius)
                        Text(presenter.pokemonDetail.name)
                            .font(.custom(FontManager.Poppins.regule, size: 12))
                            .foregroundColor(.white)
                    }
                    .frame(height: UIScreen.viewPadding*2)
                    
                }
            } else {
                VStack {
                    HStack {
                        Spacer()
                        Text(presenter.pkmIdFormat(pkmId: itemIdx))
                            .multilineTextAlignment(.trailing)
                            .font(.custom(FontManager.Poppins.bold, size: 12))
                            .foregroundColor(presenter.getTypeColor())
                    }
                    .padding(.trailing, UIScreen.viewPadding/2)
                    .padding(.top, UIScreen.viewPadding/2)
                    WebImage(url: URL(string: presenter.pokemonDetail.sprites.other.officialArtwork.frontDefault))
                        .resizable()
                        .placeholder(content: {
                            Image(uiImage: UIImage(named: "example") ?? UIImage())
                                .resizable()
                                .scaledToFit()
                        })
                        .scaledToFit()
                    ZStack {
                        presenter.getTypeColor()
                            .cornerRadius(UIScreen.pkmCornerRadius)
                        Text(itemName)
                            .font(.custom(FontManager.Poppins.regule, size: 12))
                            .foregroundColor(.white)
                    }
                    .frame(height: UIScreen.viewPadding*2)
                    
                }
                .onAppear {
                    // get pkm detail
                    presenter.fetchPKMDetail(pkmId: String(itemIdx)) {
                        self.pkmCardModel = PKMCardModel(
                            id: String(presenter.pokemonDetail.id),
                            name: presenter.pokemonDetail.name,
                            imgUrl: presenter.pokemonDetail.sprites.other.officialArtwork.frontDefault)
                    }
                }
            }
            
        }
        .frame(width: UIScreen.pkmCardWidth, height: UIScreen.pkmCardGeight)
        .onAppear {
            // paginating action
            action()
        }
    }
}

struct PKMCard_Previews: PreviewProvider {
    static var previews: some View {
        PKMCard(
            presenter: PKMDetailPresenter(
                pkmDetailUsecase: Injection.init().providePKMDetailPresenter()),
            itemIdx: 1,
            itemName: "Pokemon",
            action: {})
    }
}
