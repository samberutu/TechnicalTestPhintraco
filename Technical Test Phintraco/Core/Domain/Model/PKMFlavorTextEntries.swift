//
//  PKMFlavorTextEntries.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import Foundation

struct PKMFlavorTextEntries {
    
    let flavorTextEntries: [FlavorTextEntry]
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry {
    let flavorText: String
    let language: DescriptionProprty
}

// MARK: - Color
struct DescriptionProprty {
    let name: String
    let url: String
}
