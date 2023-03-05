//
//  LocaleUsecase.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 05/03/23.
//

import Foundation

protocol LocaleUsecase {
    func save()
    func addMyPokemon(myPkmModel: MyPKMModel)
    func editMyPokemon(myPokemon: MyPokemon, myPKMModel: MyPKMModel)
    func getMyPokemons() -> [MyPKMModel]
    func deleteMyPokemon(id: Int)
    func getMyPokemonsData() -> [MyPokemon]
}
