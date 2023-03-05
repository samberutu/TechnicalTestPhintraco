//
//  FetchPokemonEndpoint.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 04/03/23.
//

import Foundation

struct FetchPokemonEndpoint: Endpoint {
    let pokemonEndpoint: PokemonEndpoint
    
    var host: String { pokemonEndpoint.host }
    var path: String { pokemonEndpoint.path }
    var method: HTTPMethod { pokemonEndpoint.method }
    var body: [URLQueryItem]? { pokemonEndpoint.body }
}
