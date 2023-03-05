//
//  PKMListModel.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import Foundation

struct PKMListModel {
    let count: Int
    let next: String
    let previous: String
    let results: [PKMListResultModel]
}

struct PKMListResultModel {
    let id = UUID()
    let name: String
    let url: String
}
