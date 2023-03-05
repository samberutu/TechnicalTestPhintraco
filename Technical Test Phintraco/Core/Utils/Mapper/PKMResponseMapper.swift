//
//  PKMResponseMapper.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 04/03/23.
//

import Foundation

final class PKMResponseMapper {
    
    static func mapPKMListResponseToDomain(pkmListResponse: PKMListResponse) -> PKMListModel {
        return PKMListModel(
            count: pkmListResponse.count ?? 0,
            next: pkmListResponse.next ?? "",
            previous: pkmListResponse.previous ?? "",
            results: pkmListResponse.results.map({ PKMListResultResponse in
                return PKMListResultResponse.map { response in
                    return PKMListResultModel(name: response.name ?? "Unknown", url: response.url ?? "Unknown")
                }
            }) ?? [])
    }
    
    static func mapPKMDetailResponseToDomain(pkmDetailResponse: PKMDetailResponse) -> PKMDetailModel {
        return PKMDetailModel(
            height: pkmDetailResponse.height ?? 0,
            id: pkmDetailResponse.id ?? 0,
            moves: pkmDetailResponse.moves.map({ response in
                return response.map { result in
                    return Move(move:
                                    Species(
                                        name: result.move?.name ?? "Unknown",
                                        url: result.move?.url ?? "Unknown"))
                }
            }) ?? [],
            name: pkmDetailResponse.name ?? "Unknown",
            stats: pkmDetailResponse.stats.map({ response in
                return response.map { result in
                    return Stat(
                        baseStat: result.baseStat ?? 0,
                        effort: result.effort ?? 0,
                        stat: Species(
                            name: result.stat?.name ?? "Unknown",
                            url: result.stat?.url ?? "Unknown"))
                }
            }) ?? [],
            sprites: Sprites(
                other: Other(
                    officialArtwork: OfficialArtwork(
                        frontDefault: pkmDetailResponse.sprites?.other?.officialArtwork?.frontDefault ?? "Unknown",
                        frontShiny: pkmDetailResponse.sprites?.other?.officialArtwork?.frontShiny ?? "Unknown")
                )
            ),
            types: pkmDetailResponse.types.map({ response in
                return response.map { result in
                    return TypeElement(
                        slot: result.slot ?? 0,
                        type: Species(
                            name: result.type?.name ?? "Unknown",
                            url: result.type?.url ?? "Unknown"))
                }
            }) ?? [],
            weight: pkmDetailResponse.weight ?? 0)
    }
    
    static func mapPKMFlavorTextEntriesResponseToDomain(pkmFlavorTextEntriesResponse: PKMFlavorTextEntriesResponse) -> PKMFlavorTextEntries {
        return PKMFlavorTextEntries(
            flavorTextEntries: pkmFlavorTextEntriesResponse.flavorTextEntries?.map({ response in
                return FlavorTextEntry(
                    flavorText: response.flavorText ?? "Unknown",
                    language: DescriptionProprty(
                        name: response.language?.name ?? "Unknown",
                        url: response.language?.url ?? "Unknown"))
            }) ?? []
        )
    }
}
