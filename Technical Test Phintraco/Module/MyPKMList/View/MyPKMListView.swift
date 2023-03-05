//
//  MyPKMListView.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 04/03/23.
//

import SwiftUI

struct MyPKMListView: View {
    
    @ObservedObject var presenter: MyPKMListPresenter
    
    var body: some View {
        ZStack {
            List {
                ForEach(presenter.myPokemon, id: \.id) { myPokemon in
                    ZStack {
                        MyPKMCard(myPokemon: myPokemon, bgColor: presenter.getTypeColor(type: myPokemon.typeColor))
                        presenter.linkBuilder(pkmId: myPokemon.id) {
                            EmptyView()
                        }
                    }
                    .swipeActions {
                        HStack {
                            Button {
                                presenter.deleteMyPokemon(pkmId: myPokemon.id)
                            } label: {
                                Image(systemName: "trash.fill")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .tint(.red)
                            
                            Button {
                                presenter.setupEdit(
                                    pkmId: myPokemon.id,
                                    pkmName: myPokemon.name,
                                    myPkmModel: myPokemon)
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .tint(.green)
                        }
                    }
                }
            }
            
            if presenter.showEditMyPokemon {
                Color.black
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                EditPokemonPopupView(
                    isShowPopup: $presenter.showEditMyPokemon,
                    pkmName: $presenter.currentPKMName,
                    pkmImgURL: presenter.currentPkMImgURL,
                    description: "Rename My Pokemon") {
                        presenter.updateMyPokemon()
                        presenter.getMyPokemons()
                    }
            }
        }
        .listStyle(.plain)
        .onAppear {
            presenter.getMyPokemons()
        }
        .navigationTitle("My Pokemon")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyPKMListView_Previews: PreviewProvider {
    static var previews: some View {
        MyPKMListView(presenter: MyPKMListPresenter(localeUsecase: Injection.init().provideMyPKMListPresenter()))
    }
}
