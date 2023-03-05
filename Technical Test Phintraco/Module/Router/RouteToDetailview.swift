//
//  RouteToDetailview.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import SwiftUI

class RouteToDetailview {
    
    let localeUsecase = Injection.init().provideMyPKMListPresenter()
    let remoteDetailUsecase = Injection.init().providePKMDetailPresenter()
    
    func makeDetailView(pkmId: String, pkmCount: Int) -> some View {
        let detailPresenter = PKMDetailPresenter(pkmDetailUsecase: remoteDetailUsecase)
        return PKMDetailView(pkmId: pkmId, pkmCount: pkmCount, presenter: detailPresenter)
    }
    
    func makeMyPKMListView() -> some View {
        let myPKMListPresenter = MyPKMListPresenter(localeUsecase: localeUsecase)
        return MyPKMListView(presenter: myPKMListPresenter)
    }
    
}
