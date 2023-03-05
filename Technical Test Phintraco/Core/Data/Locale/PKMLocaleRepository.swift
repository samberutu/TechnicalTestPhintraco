//
//  PKMLocaleRepository.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 05/03/23.
//

import Foundation
import CoreData

protocol PKMLocaleRepositoryProtocol {
    func save()
    func addMyPokemon(myPkmModel: MyPKMModel)
    func editMyPokemon(myPokemon: MyPokemon, myPKMModel: MyPKMModel)
    func getMyPokemons() -> [MyPKMModel]
    func deleteMyPokemon(id: Int)
    func getMyPokemonsData() -> [MyPokemon]
}

class PKMLocaleRepository: ObservableObject {
    typealias MyPokemonInstance = (PKMLocaleDataSource) -> PKMLocaleRepository
    fileprivate var dataSource: PKMLocaleDataSource
    
    internal init(dataSource: PKMLocaleDataSource) {
        self.dataSource = dataSource
    }
    
    static let sharedInstance: MyPokemonInstance = { myPokemonDataSource in
        return PKMLocaleRepository(dataSource: myPokemonDataSource)
    }
}

extension PKMLocaleRepository: PKMLocaleRepositoryProtocol {
    func save() {
        dataSource.save()
    }
    
    func addMyPokemon(myPkmModel: MyPKMModel) {
        dataSource.addMyPokemon(myPkmModel: myPkmModel)
    }
    
    func editMyPokemon(myPokemon: MyPokemon, myPKMModel: MyPKMModel) {
        dataSource.editMyPokemon(myPokemon: myPokemon, myPKMModel: myPKMModel)
    }
    
    func getMyPokemons() -> [MyPKMModel] {
        dataSource.getMyPokemons()
    }
    
    func deleteMyPokemon(id: Int) {
        dataSource.deleteMyPokemon(id: id)
    }
    
    func getMyPokemonsData() -> [MyPokemon] {
        dataSource.getMyPokemonsData()
    }
    
}
