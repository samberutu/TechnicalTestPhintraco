//
//  PKMCardPresenter.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import Foundation
import Combine
import SwiftUI

class PKMCardPresenter: ObservableObject {
    @Published var pokemonDetail = PKMDetailModel.seeder
    @Published var isLoadData = false
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var pkmDescription = "Description"
    @Published var didFetchCounter = 0
    
}
