//
//  PKMListPresenter.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import SwiftUI
import Combine

class PKMListPresenter: ObservableObject {
    let router = RouteToDetailview()
    private let remoteUsecase: RemoteUsecase
    private var cancellables: Set<AnyCancellable> = []
    @Published var result: [PKMListResultModel] = []
    @Published var isLoadData = false
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var didFetchCounter = 0
    @Published var previouwsLink: String = ""
    @Published var nextLink: String = ""
    @Published var isPaginating = false
    @Published var offsetItem = 30
    @Published var limitItem = 30
    @Published var itemCount = 1279
    @Published var didFetchData = false
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(remoteUsecase: RemoteUsecase) {
        self.remoteUsecase = remoteUsecase
    }
    
    func fetchPKMList() {
        isPaginating = true
        isLoadData.toggle()
        isError = false
        didFetchCounter += 1
        let endpoint = FetchPokemonEndpoint(pokemonEndpoint: .getPKMList(offset: offsetItem, limit: limitItem))
        remoteUsecase.request(to: endpoint, decodeTo: PKMListResponse.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                    
                case .finished:
                    self.isPaginating = false
                    self.offsetItem += 30
                    self.didFetchData = true
                case .failure(let error):
                    self.offsetItem -= 30
                    self.errorMessage = error.errorMessage
                    self.isLoadData.toggle()
                    self.isError = true && self.didFetchCounter < 3
                }
            } receiveValue: { response in
                let responseResult = PKMResponseMapper.mapPKMListResponseToDomain(pkmListResponse: response)
                self.itemCount = responseResult.count
                self.result.append(contentsOf: responseResult.results)
            }
            .store(in: &cancellables)
    }
    
    func createProgressView(view: UIView) -> UIView {
        let footerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: 100))
        let progressView = UIActivityIndicatorView()
        progressView.center = footerView.center
        footerView.addSubview(progressView)
        progressView.startAnimating()
        return footerView
    }
    
    func getPKMId(url: String) -> Int {
        guard url.count > 2 else { return 0 }
        let idx = url.index(url.endIndex, offsetBy: -2)
        return Int(String(url[idx])) ?? 0
    }
    
    func provideDetailPresenter() -> PKMDetailPresenter {
        let pkmDetailUsecase = Injection.init().providePKMDetailPresenter()
        return PKMDetailPresenter(pkmDetailUsecase: pkmDetailUsecase)
    }
    
    func linkBuilder<Content: View>(pkmId: String, pkmCount: Int, @ViewBuilder content: () -> Content ) -> some View {
        NavigationLink(destination: router.makeDetailView(pkmId: pkmId, pkmCount: itemCount)) {
            content()
        }
    }
    
    func routingToMyPokemon<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        ZStack {
            content()
            NavigationLink {
                router.makeMyPKMListView()
            } label: {
                EmptyView()
            }
            .opacity(0.0)

        }

    }
    
    func startPaginating(itemIdx: Int) {
        if itemIdx == result.count - 4 {
            print("Stat paginating")
            fetchPKMList()
        }
            
    }
}
