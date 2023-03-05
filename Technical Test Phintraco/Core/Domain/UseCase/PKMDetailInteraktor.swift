//
//  PKMDetailInteraktor.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 05/03/23.
//

import Foundation
import Combine

protocol PKMDetailUsecase: RemoteUsecase, LocaleUsecase { }

class PKMDetailInteraktor {
    
    private let remoteRepository: PKMRemoteRepositoryProtocol
    private let localeRepository: PKMLocaleRepositoryProtocol
    required init(remoteRepository: PKMRemoteRepositoryProtocol, localeRepository: PKMLocaleRepositoryProtocol) {
        self.remoteRepository = remoteRepository
        self.localeRepository = localeRepository
    }
}

extension PKMDetailInteraktor: PKMDetailUsecase {
    func request<T, E>(
        to endpoint: E,
        decodeTo model: T.Type) -> AnyPublisher<T, NetworkError> where T: Decodable, E: Endpoint {
            return remoteRepository.request(to: endpoint, decodeTo: model)
        }
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
