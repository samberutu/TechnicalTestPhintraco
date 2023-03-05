//
//  PKMListInteractor.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 05/03/23.
//

import Foundation
import Combine

class PKMListInteractor: RemoteUsecase {
    
    private let remoteRepository: PKMRemoteRepositoryProtocol
    required init(remoteRepository: PKMRemoteRepositoryProtocol) {
        self.remoteRepository = remoteRepository
    }
    
    func request<T, E>(to endpoint: E, decodeTo model: T.Type) -> AnyPublisher<T, NetworkError> where T: Decodable, E: Endpoint {
        return remoteRepository.request(to: endpoint, decodeTo: model)
    }
    
}
