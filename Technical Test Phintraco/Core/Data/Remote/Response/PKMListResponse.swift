//
//  PKMListResponse.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 04/03/23.
//

import Foundation

struct PKMListResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PKMListResultResponse]?
}

struct PKMListResultResponse: Decodable {
    let name: String?
    let url: String?
}
