//
//  PKMDetailModel.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import Foundation

// MARK: - PokemonDetail
struct PKMDetailModel {
    let height: Int
    let id: Int
    let moves: [Move]
    let name: String
    let stats: [Stat]
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int

}

// MARK: - Ability
struct Ability {
    let ability: Species
    let isHidden: Bool
    let slot: Int
}

// MARK: - Species
struct Species {
    let name: String
    let url: String
}

// MARK: - GameIndex
struct GameIndex {
    let gameIndex: Int
    let version: Species

}

// MARK: - Move
struct Move {
    let move: Species
}

// MARK: - Stat
struct Stat {
    let baseStat, effort: Int
    let stat: Species
    
    static let seeder = Stat(baseStat: 0,
                             effort: 0,
                             stat: Species(name: "",
                                           url: ""))
}

// MARK: - TypeElement
struct TypeElement {
    let slot: Int
    let type: Species
}

// MARK: - Sprites
struct Sprites {
    let other: Other
}

// MARK: - Other
struct Other {
    let officialArtwork: OfficialArtwork
}

// MARK: - OfficialArtwork
struct OfficialArtwork {
    let frontDefault, frontShiny: String
}

extension PKMDetailModel {
    static let seeder = PKMDetailModel(height: 0,
                                       id: 0,
                                       moves: [],
                                       name: "loading...",
                                       stats: [],
                                       sprites: Sprites(other: Other(officialArtwork: OfficialArtwork(frontDefault: "",
                                                                                                      frontShiny: ""))),
                                       types: [],
                                       weight: 0)
}
