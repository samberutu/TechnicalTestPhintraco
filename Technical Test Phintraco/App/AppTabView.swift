//
//  AppTabView.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import SwiftUI

struct AppTabView: View {
    let remoteUsecase = Injection.init().providePKMListPresenter()
    var body: some View {
        let pkmListPresenter = PKMListPresenter(remoteUsecase: remoteUsecase)
        NavigationView {
            PKMListView(presenter: pkmListPresenter)
                .navigationTitle("Pokemon")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
