//
//  PKMRemoteRepository.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 04/03/23.
//

import Combine

protocol PKMRemoteRepositoryProtocol {
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) -> AnyPublisher<T, NetworkError>
}

class PKMRemoteRepository {
    typealias PKMInstance = (NetworkService) -> PKMRemoteRepository
    
    fileprivate let networkService: NetworkService
    
    internal init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    static let sharedInstance: PKMInstance = { networkService in
        return PKMRemoteRepository(networkService: networkService)
    }
}

extension PKMRemoteRepository: PKMRemoteRepositoryProtocol {
    func request<T, E>(to endpoint: E, decodeTo model: T.Type) -> AnyPublisher<T, NetworkError> where T: Decodable, E: Endpoint {
        networkService.request(to: endpoint, decodeTo: model)
    }
}
