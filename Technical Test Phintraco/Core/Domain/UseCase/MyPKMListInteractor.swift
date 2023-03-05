//
//  MyPKMListInteractor.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 05/03/23.
//

import Foundation

class MyPKMListInteractor {
    private let localeRepository: PKMLocaleRepositoryProtocol
    required init(localeRepository: PKMLocaleRepositoryProtocol) {
        self.localeRepository = localeRepository
    }
}

extension MyPKMListInteractor: LocaleUsecase {
    func save() {
        localeRepository.save()
    }
    
    func addMyPokemon(myPkmModel: MyPKMModel) {
        localeRepository.addMyPokemon(myPkmModel: myPkmModel)
    }
    
    func editMyPokemon(myPokemon: MyPokemon, myPKMModel: MyPKMModel) {
        localeRepository.editMyPokemon(myPokemon: myPokemon, myPKMModel: myPKMModel)
    }
    
    func getMyPokemons() -> [MyPKMModel] {
        localeRepository.getMyPokemons()
    }
    
    func deleteMyPokemon(id: Int) {
        localeRepository.deleteMyPokemon(id: id)
    }
    
    func getMyPokemonsData() -> [MyPokemon] {
        localeRepository.getMyPokemonsData()
    }
    
}
