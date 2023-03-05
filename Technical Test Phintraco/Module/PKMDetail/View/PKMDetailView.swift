//
//  PKMDetailView.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PKMDetailView: View {
    @Environment(\.presentationMode) var presentation
    @State private var imagePosition: CGPoint = .zero
    let pkmId: String
    let pkmCount: Int
    @ObservedObject var presenter: PKMDetailPresenter
    
    var body: some View {
        ZStack {
            // bgcolor
            presenter.getTypeColor()
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Image(uiImage: UIImage(named: "Pokeball") ?? UIImage())
                        .resizable()
                        .frame(width: (UIScreen.screenWidth/5)*3, height: (UIScreen.screenWidth/5)*3)
                        .padding(.top, -16)
                }
                .padding(.trailing, 8)
                Spacer()
            }
            ScrollView {
                VStack {
                    HStack {
                        Button {
                            presentation.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .foregroundColor(.white)
                                .scaledToFit()
                                .frame(width: 24)
                        }
                        
                        Text(presenter.currentPokemonName)
                            .font(.custom(FontManager.Poppins.bold, size: 24))
                            .bold()
                            .lineLimit(1)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                        Spacer()
                        Text("#\(String(format: "%04d", presenter.pokemonDetail.id))")
                            .font(.custom(FontManager.Poppins.bold, size: 12))
                            .bold()
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                    }
                    .frame(height: 32)
                    .padding(.horizontal, 24)
                    ZStack {
                        VStack {
                            HStack {
                                if presenter.pokemonDetail.id <= 1 {
                                    Spacer()
                                } else {
                                    Button {
                                        presenter.setupNewValue()
                                        presenter.fetchPKMDetail(pkmId: String(presenter.pokemonDetail.id - 1))
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .foregroundColor(ColorManager.PKMWhite)
                                    }
                                }
                                Spacer()
                                if presenter.pokemonDetail.id >= pkmCount {
                                    Spacer()
                                } else {
                                    Button {
                                        presenter.setupNewValue()
                                        presenter.fetchPKMDetail(pkmId: String(presenter.pokemonDetail.id + 1))
                                    } label: {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(ColorManager.PKMWhite)
                                    }
                                }
                            }
                            .frame(height: 16)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            ZStack {
                                ColorManager.PKMBackground
                                    .ignoresSafeArea(.all)
                                    .cornerRadius(8.0)
                            }
                        }
                        .padding(.top, UIScreen.screenHeight/7)
                        .padding(.bottom, 4)
                        VStack {
                            WebImage(url: URL(string: presenter.pokemonDetail.sprites.other.officialArtwork.frontDefault))
                                .resizable()
                                .placeholder(content: {
                                    Image(uiImage: UIImage(named: "example") ?? UIImage()).resizable()
                                })
                                .indicator(.activity)
                                .scaledToFit()
                                .frame(
                                    width: UIScreen.screenWidth/2,
                                    height: UIScreen.screenWidth/2)
                                
                            HStack {
                                // PKM type
                                ForEach(presenter.pokemonDetail.types.indices, id: \.self) { idx in
                                    let species = presenter.pokemonDetail.types[idx].type
                                    let bgColor = presenter.getTypesColor()[idx]
                                    PokemonTypeView(title: species.name, bgColor: bgColor)
                                }
//                                .scrollDisabled(true)
                            }
                            Text("About")
                                .foregroundColor(presenter.getTypeColor())
                                .font(.custom(FontManager.Poppins.bold, size: 14))
                                .padding(.top, 16)
                            AboutView(weight: presenter.pokemonDetail.weight,
                                      height: presenter.pokemonDetail.height,
                                      moves: presenter.getMoves())
                            .padding(.top)
                            Text(presenter.pkmDescription
                                .replacingOccurrences(of: "\\f", with: " "))
                                .font(.custom(FontManager.Poppins.regule, size: 10))
                                .foregroundColor(.black)
                                .lineLimit(3)
                                .padding(.top, 16)
                            Text("Base Stats")
                                .foregroundColor(presenter.getTypeColor())
                                .font(.custom(FontManager.Poppins.bold, size: 14))
                                .padding(.top, 16)
                            // stat
                            VStack {
                                ForEach(presenter.pokemonDetail.stats.indices, id: \.self) { idx in
                                    StatView(title: presenter.getStatTitle()[idx],
                                             value: String(presenter.pokemonDetail.stats[idx].baseStat),
                                             color: presenter.getTypeColor())
                                }
                            }
                            .padding(.top, 16)
                            .padding(.bottom, 32)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 32)
                    }
                    .padding(.horizontal, 8)
                }
            }
            VStack {
                Spacer()
                Spacer()
                HStack {
                    Spacer()
                    // MARK: - Catch Pokemon
                    CatchPokemon(action: {
                        presenter.tryTocatchPokemon()
                    })
                }
                .padding()
            }
            .ignoresSafeArea()
            
            // Loading View
            if presenter.isLoadData {
                Color.black
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ProgressView()
                        .scaleEffect(2)
                        .foregroundColor(.white)
                    Text("Loading")
                        .font(.custom(FontManager.Poppins.bold, size: 14))
                        .foregroundColor(.white)
                        .padding()
                }
                
            }
            // Catching Pokemon Alert
            if presenter.showPopupView {
                Color.black
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                
                EditPokemonPopupView(
                    isShowPopup: $presenter.showPopupView,
                    pkmName: $presenter.currentPokemonName,
                    pkmImgURL: presenter.pokemonDetail.sprites.other.officialArtwork.frontDefault,
                    description: "you can catch this pokemon.\nPlease change your Pokemon name") {
                        let pokemonData = presenter.pokemonDetail
                        presenter.addToMyPokemon(
                            id: String(pokemonData.id),
                            name: presenter.currentPokemonName,
                            imgURL: pokemonData.sprites.other.officialArtwork.frontDefault)
                        print("Catch")
                    }
            }
        }
        .alert(isPresented: $presenter.isError) {
            Alert(title: Text("Error"),
                  message: Text(presenter.errorMessage),
                  dismissButton: .default(Text("Muat Ulang"), action: {
                guard presenter.pokemonDetail.id != 0 else {
                    presenter.fetchPKMDetail(pkmId: pkmId)
                    return
                }
                presenter.fetchPKMDetail(pkmId: String(presenter.pokemonDetail.id))
            }))
        }
        .alert(isPresented: $presenter.showAlertNotPossibleToCatch) {
            Alert(title: Text("Hmm....").font(.custom(FontManager.Poppins.bold, size: 14)),
                  message: Text("You are not lucky enough to catch this pokemon")
                .font(.custom(FontManager.Poppins.regule, size: 14)),
                  dismissButton: .cancel())
        }
        .navigationBarHidden(true)
        .onAppear {
            presenter.fetchPKMDetail(pkmId: pkmId)
        }
    }
    
}

struct PKMDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PKMDetailView(pkmId: "1", pkmCount: 12, presenter: PKMDetailPresenter(pkmDetailUsecase: Injection.init().providePKMDetailPresenter()))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
