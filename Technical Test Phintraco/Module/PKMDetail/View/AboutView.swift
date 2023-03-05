//
//  AboutView.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import SwiftUI

struct AboutView: View {
    let weight: Int
    let height: Int
    let moves: [String]
    let aboutTitle: [String] = ["Weight", "Height", "Moves"]
    let idx = 0
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Image(systemName: "scalemass")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("\(weight) kg")
                        .font(.custom(FontManager.Poppins.regule, size: 10))
                }
                .frame(height: 32)
                Text("Weight")
                    .font(.custom(FontManager.Poppins.regule, size: 8))
            }
            .padding(.trailing, 12)
            Divider()
            VStack {
                HStack {
                    Image(systemName: "ruler")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(-90))
                        .frame(width: 16, height: 16)
                    Text("\(height) m")
                        .font(.custom(FontManager.Poppins.regule, size: 10))
                }
                .frame(height: 32)
                Text("Height")
                    .font(.custom(FontManager.Poppins.regule, size: 8))
            }
            .padding(.horizontal, 12)
            Divider()
            VStack {
                VStack {
                    ForEach(moves.indices, id: \.self) { idx in
                        Text(moves[idx])
                            .font(.custom(FontManager.Poppins.regule, size: 10))
                            .lineLimit(1)
                    }
                }
                .frame(height: 32)
                Text("Moves")
                    .font(.custom(FontManager.Poppins.regule, size: 8))
            }
            .padding(.leading, 12)
        }
        .foregroundColor(.black)
        .frame(height: 48)
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(weight: 30, height: 20, moves: ["lari", "terbang"])
    }
}
