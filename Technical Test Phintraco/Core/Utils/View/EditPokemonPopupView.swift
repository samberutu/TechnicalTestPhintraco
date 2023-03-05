//
//  EditPokemonPopupView.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 05/03/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditPokemonPopupView: View {
    @Binding var isShowPopup: Bool
    @Binding var pkmName: String
    var pkmImgURL: String
    var description: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isShowPopup = false
                } label: {
                    Image(systemName: "xmark")
                        .scaledToFit()
                        .foregroundColor(.red)
                }
            }
            .padding()
            
            Text(description)
                .font(.custom(FontManager.Poppins.bold, size: 14))
                .multilineTextAlignment(.center)
                .padding()
            
            WebImage(url: URL(string: pkmImgURL))
                .resizable()
                .placeholder(content: {
                    Image(uiImage: UIImage(named: "example") ?? UIImage())
                })
                .scaledToFit()
                .frame(width: 64, height: 64)
            
            TextField("Enter text here", text: $pkmName)
                .font(.custom(FontManager.Poppins.regule, size: 12))
                .multilineTextAlignment(.center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocorrectionDisabled()
                .padding()
            
            Button {
                self.isShowPopup = false
                action()
            } label: {
                Text("OK")
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(ColorManager.PKMWater)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .frame(width: UIScreen.screenWidth / 1.5, height: UIScreen.screenWidth)
        .background(Color.white)
        .cornerRadius(UIScreen.pkmCornerRadius)
        .shadow(radius: 10)
    }
}

struct EditPokemonPopupView_Previews: PreviewProvider {
    static var previews: some View {
        EditPokemonPopupView(
            isShowPopup: .constant(true),
            pkmName: .constant("pokemon Name"),
            pkmImgURL: "nn", description: "Rename My Pokemon",
            action: { })
    }
}
