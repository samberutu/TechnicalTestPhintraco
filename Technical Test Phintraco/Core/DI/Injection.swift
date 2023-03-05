//
//  Injection.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 04/03/23.
//

import Foundation

final class Injection {
    private func provideRemoteRepository() -> PKMRemoteRepositoryProtocol {
        let networkService: NetworkService = NetworkService.sharedInstance
        return PKMRemoteRepository.sharedInstance(networkService)
    }
    
    private func provideLocaleRepository() -> PKMLocaleRepositoryProtocol {
        let myPokemonDataSource = PKMLocaleDataSource.sharedInstance               
        return PKMLocaleRepository(dataSource: myPokemonDataSource)
    }
    
    func providePKMListPresenter() -> RemoteUsecase {
        let repository = self.provideRemoteRepository()
        return PKMListInteractor(remoteRepository: repository)
    }
    
    func providePKMDetailPresenter() -> PKMDetailUsecase {
        let remoteRepository = self.provideRemoteRepository()
        let localeRepository = self.provideLocaleRepository()
        return PKMDetailInteraktor(remoteRepository: remoteRepository, localeRepository: localeRepository)
    }
    
    func provideMyPKMListPresenter() -> LocaleUsecase {
        let localeRepository = self.provideLocaleRepository()
        return MyPKMListInteractor(localeRepository: localeRepository)
    }
}
