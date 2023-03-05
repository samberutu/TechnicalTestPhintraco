//
//  RequestUsecaseProtocol.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 05/03/23.
//

import Foundation
import Combine

protocol RemoteUsecase {
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) -> AnyPublisher<T, NetworkError>
}
