//
//  PKMDetailResponse.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 04/03/23.
//

import Foundation

struct PKMDetailResponse: Decodable {
    let height: Int?
    let id: Int?
    let moves: [MoveResponse]?
    let name: String?
    let stats: [StatResponse]?
    let sprites: SpritesResponse?
    let types: [TypeElementResponse]?
    let weight: Int?

}

// MARK: - Ability
struct AbilityResponse: Decodable {
    let ability: SpeciesResponse?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct SpeciesResponse: Decodable {
    let name: String?
    let url: String?
}

// MARK: - GameIndex
struct GameIndexResponse: Decodable {
    let gameIndex: Int?
    let version: SpeciesResponse?

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - Move
struct MoveResponse: Decodable {
    let move: SpeciesResponse?
}

// MARK: - Stat
struct StatResponse: Decodable {
    let baseStat, effort: Int?
    let stat: SpeciesResponse?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElementResponse: Decodable {
    let slot: Int?
    let type: SpeciesResponse?
}

// MARK: - Sprites
class SpritesResponse: Decodable {
    let other: OtherResponse?
}

// MARK: - Other
struct OtherResponse: Decodable {
    let officialArtwork: OfficialArtworkResponse?

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtworkResponse: Decodable {
    let frontDefault, frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
