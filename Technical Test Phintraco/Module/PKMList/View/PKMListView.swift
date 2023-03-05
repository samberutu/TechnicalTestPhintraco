//
//  PKMListView.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import SwiftUI

struct PKMListView: View {
    @ObservedObject var presenter: PKMListPresenter
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: presenter.columns, spacing: UIScreen.viewPadding) {
                ForEach(presenter.result.indices, id: \.self) { index in
                    let pkmId = Int(index) + 1
                    presenter.linkBuilder(pkmId: "\(pkmId)", pkmCount: 24) {
                        PKMCard(
                            presenter: presenter.provideDetailPresenter(),
                            itemIdx: pkmId,
                            itemName: presenter.result[index].name,
                            action: {
                                presenter.startPaginating(itemIdx: pkmId)
                            })
                    }
                    .id(pkmId)
                }
            }
            .padding(.horizontal, UIScreen.viewPadding)
        }
        .onAppear {
            // paginating
            if !presenter.didFetchData {
                presenter.fetchPKMList()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    presenter.router.makeMyPKMListView()
                } label: {
                    Image(uiImage: UIImage(named: "PokeballCatch") ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 42, height: 42, alignment: .trailing)
                }
            }
        }
        .alert(isPresented: $presenter.isError) {
            Alert(title: Text("Error"),
                  message: Text(presenter.errorMessage),
                  dismissButton: .default(Text("Muat Ulang"), action: {
                guard presenter.isError else {
                        presenter.fetchPKMList()
                    return
                }
            }))
        }
    }
}

 struct PKMListView_Previews: PreviewProvider {
    static var previews: some View {
        PKMListView(presenter: PKMListPresenter(remoteUsecase: Injection.init().providePKMListPresenter()))
    }
}
