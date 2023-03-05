//
//  PKMFlavorTextEntries.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 04/03/23.
//

import Foundation

struct PKMFlavorTextEntriesResponse: Decodable {
    
    let flavorTextEntries: [FlavorTextEntryResponse]?
    
    enum CodingKeys: String, CodingKey {
            case flavorTextEntries = "flavor_text_entries"
        }
}

// MARK: - FlavorTextEntry
struct FlavorTextEntryResponse: Decodable {
    let flavorText: String?
    let language: DescriptionProprtyResponse?

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

// MARK: - Color
struct DescriptionProprtyResponse: Decodable {
    let name: String?
    let url: String?
}
