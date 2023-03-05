//
//  MyPKMListPresenter.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 05/03/23.
//

import SwiftUI

class MyPKMListPresenter: ObservableObject {
    
    @Published var myPokemon: [MyPKMModel] = []
    @Published var showEditMyPokemon = false
    @Published var currentPKMName = ""
    @Published var currentPKMId = ""
    @Published var currentPkMImgURL = ""
    @Published var myPKMModel = MyPKMModel(
        id: "",
        name: "",
        imgURL: "",
        fibonancci: "",
        typeColor: "",
        editedCount: 0)
    let router = RouteToDetailview()
    
    private let localeUsecase: LocaleUsecase
    
    init(localeUsecase: LocaleUsecase) {
        self.localeUsecase = localeUsecase
    }
    
    func getMyPokemons() {
        DispatchQueue.main.async {
            self.myPokemon = self.localeUsecase.getMyPokemons().sorted( by: { $0.id > $1.id })
        }
    }
    
    func linkBuilder<Content: View>(pkmId: String, @ViewBuilder content: () -> Content ) -> some View {
        NavigationLink {
            router.makeDetailView(pkmId: pkmId, pkmCount: 1279)
        } label: {
            EmptyView()
        }
        .opacity(0.0)
        .buttonStyle(.plain)

    }
    
    func setupEdit(pkmId: String, pkmName: String, myPkmModel: MyPKMModel) {
        currentPKMName = pkmName
        currentPKMId = pkmId
        showEditMyPokemon = true
        currentPkMImgURL = myPkmModel.imgURL
        myPKMModel = myPkmModel
    }
    
    func updateMyPokemon() {
        if checkItemDidAdded(id: currentPKMId) {
            guard let myPokemon = localeUsecase.getMyPokemonsData().filter({ $0.id == currentPKMId}).first else { return }
            let newValue = MyPKMModel(
                id: currentPKMId,
                name: currentPKMName,
                imgURL: currentPkMImgURL,
                fibonancci: "0",
                typeColor: myPKMModel.typeColor,
                editedCount: 0)
            DispatchQueue.global().async {
                self.localeUsecase.editMyPokemon(
                    myPokemon: myPokemon,
                    myPKMModel: newValue)
            }
        }
    }
    
    func deleteMyPokemon(pkmId: String) {
        guard localeUsecase.getMyPokemons().filter({ $0.id == pkmId }).first != nil else { return }
        localeUsecase.deleteMyPokemon(id: Int(pkmId) ?? 0)
        self.getMyPokemons()
    }
    
    func checkItemDidAdded(id: String) -> Bool {
        guard localeUsecase.getMyPokemons().filter({ $0.id == id }).first != nil else { return false }
        return true
    }
    
    func getTypeColor(type: String) -> Color {
        let pkmType = PKMType.allCases.filter { $0.rawValue == type }.first
        guard let type = pkmType?.typeColor else { return ColorManager.PKMNormal }
        return type
    }
}
