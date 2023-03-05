//
//  PKMDetailPresenter.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import SwiftUI
import Combine

class PKMDetailPresenter: ObservableObject {
    @Published var pokemonDetail = PKMDetailModel.seeder
    @Published var isLoadData = false
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var pkmDescription = "Description"
    @Published var didFetchCounter = 0
    @Published var typeColor = ColorManager.PKMNormal
    @Published var typesColor: [Color] = []
    @Published var isDragging = false
    @Published var pokeballPosition = CGSize.zero
    @Published var pokemonPosition: CGSize = .zero
    @Published var itemPossibleToCatch = false
    @Published var showPopupView = false
    @Published var currentPokemonName = ""
    @Published var showAlertNotPossibleToCatch = false
    let targetFrame = CGRect(x: 50, y: 50, width: 100, height: 100)
    
    private let pkmDetailUsecase: PKMDetailUsecase
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(pkmDetailUsecase: PKMDetailUsecase) {
        self.pkmDetailUsecase = pkmDetailUsecase
    }
    // MARK: - remoter function
    func fetchPKMDetail(pkmId: String, getData: (() -> Void)? = nil) {
        isLoadData.toggle()
        isError = false
        didFetchCounter += 1
        let endpoint = FetchPokemonEndpoint(pokemonEndpoint: .getPKMDetail(id: pkmId))
        pkmDetailUsecase.request(to: endpoint, decodeTo: PKMDetailResponse.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.fetchPKMDescription()
                    self.isItemPossibleCaught()
                case .failure(let error):
                    self.errorMessage = error.errorMessage
                    self.isLoadData.toggle()
                    self.isError = true && self.didFetchCounter < 3
                }
            } receiveValue: { response in
                let result = PKMResponseMapper.mapPKMDetailResponseToDomain(pkmDetailResponse: response)
                self.pokemonDetail = result
                self.currentPokemonName = result.name
                self.preparePokemonName()
                getData?()
            }
            .store(in: &cancellables)
    }
    
    func fetchPKMDescription() {
        let endpoint = FetchPokemonEndpoint(pokemonEndpoint: .getPokemonDesc(id: String(pokemonDetail.id)))
        pkmDetailUsecase.request(to: endpoint, decodeTo: PKMFlavorTextEntriesResponse.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoadData.toggle()
                    self.isError = false
                case .failure(let error):
                    self.errorMessage = error.errorMessage
                    self.isLoadData.toggle()
                    self.isError = true && self.didFetchCounter < 3
                }
            } receiveValue: { species in
                let result = PKMResponseMapper.mapPKMFlavorTextEntriesResponseToDomain(pkmFlavorTextEntriesResponse: species)
                self.getRandomDescription(descriptions: result.flavorTextEntries)
            }
            .store(in: &cancellables)
    }

    func getRandomDescription(descriptions: [FlavorTextEntry]) {
        let englishDesc = descriptions.filter { $0.language.name.contains("en") }
        guard englishDesc.count > 1 else { return }
        pkmDescription = englishDesc[Int.random(in: 0..<englishDesc.count)].flavorText
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\\", with: " ")
    }
    
    func getTypeColor() -> Color {
        let types = pokemonDetail.types.map { $0.type }
        guard let firstIndex = types.first else { return ColorManager.PKMNormal}
        let pkmType = PKMType.allCases.filter { $0.rawValue == firstIndex.name }.first
        guard let type = pkmType?.typeColor else { return ColorManager.PKMNormal }
        return type
    }
    
    func getTypesColor() -> [Color] {
        let types = pokemonDetail.types.map { $0.type }
        let colors = types.map { type in
            return UIColor(PKMType.allCases.filter { $0.rawValue == type.name }.first?.typeColor ?? ColorManager.PKMNormal)
        }
        return colors.map { Color($0) }
    }
    
    func getMoves() -> [String] {
        guard pokemonDetail.moves.count > 2 else { return [] }
        return pokemonDetail.moves[0...1].map { $0.move.name }
    }
    
    func getStatTitle() -> [String] {
        let statsTitle = pokemonDetail.stats.map { $0.stat.name }
        let convertedTitle: [String] = statsTitle.map { stat in
            return PKMStatsManager.allCases.filter { $0.rawValue == stat }.first?.statType ?? stat
        }
        
        return convertedTitle
    }
    
    func pkmIdFormat(pkmId: Int) -> String {
        "#\(String(format: "%04d", pkmId))"
    }
    
    func setupNewValue() {
        didFetchCounter = 0
    }
    
    // MARK: - locale function
    func preparePokemonName() {
        if checkItemDidAdded(id: String(pokemonDetail.id)) {
            guard let myPokemon = pkmDetailUsecase.getMyPokemonsData().filter({ $0.id == String(pokemonDetail.id)}).first else { return }
            currentPokemonName = myPokemon.name ?? pokemonDetail.name
        } else {
            currentPokemonName = pokemonDetail.name
        }
    }
    
    func addToMyPokemon(id: String, name: String, imgURL: String) {
        if itemPossibleToCatch {
            if checkItemDidAdded(id: id) {
                let myPokemon = pkmDetailUsecase.getMyPokemonsData().filter({ $0.id == id}).first
                let newValue = MyPKMModel(
                    id: id,
                    name: name,
                    imgURL: imgURL,
                    typeColor: getTypeColorLbl())
                DispatchQueue.global().async {
                    guard let addedMyPokemon = myPokemon else { return }
                    self.pkmDetailUsecase.editMyPokemon(myPokemon: addedMyPokemon, myPKMModel: newValue)
                }
            } else {
                let myPKMModel = MyPKMModel(
                    id: id, name: name, imgURL: imgURL, typeColor: getTypeColorLbl())
                DispatchQueue.global().async {
                    self.pkmDetailUsecase.addMyPokemon(myPkmModel: myPKMModel)
                }
            }
        }
        reloadCatchingProperty()
    }
    
    func getTypeColorLbl() -> String {
        let types = pokemonDetail.types.map { $0.type }
        guard let firstIndex = types.first else { return "Unknown"}
        let pkmType = PKMType.allCases.filter { $0.rawValue == firstIndex.name }.first
        guard pkmType != nil else { return "Unknown" }
        return pkmType?.rawValue ?? "Unknown"
    }
    
    func tryTocatchPokemon() {
        if itemPossibleToCatch {
            showPopupView = true
        } else {
            showAlertNotPossibleToCatch = true
        }
    }
    
    func reloadCatchingProperty() {
        itemPossibleToCatch = false
        showPopupView = false
        showPopupView = false
    }
    
    func checkItemDidAdded(id: String) -> Bool {
        guard pkmDetailUsecase.getMyPokemons().filter({ $0.id == id }).first != nil else { return false }
        return true
    }
    
    func isItemPossibleCaught() {
        // MARK: - get 50% possible to catch pokemon (it's mean user has two options, true or false)
        itemPossibleToCatch = Bool.random()
    }
}
