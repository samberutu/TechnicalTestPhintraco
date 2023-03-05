//
//  PKMLocaleDataSource.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 05/03/23.
//

import Foundation
import CoreData

protocol PKMLocaleDataSourceProtocol {
    func save()
    func addMyPokemon(myPkmModel: MyPKMModel)
    func editMyPokemon(myPokemon: MyPokemon, myPKMModel: MyPKMModel)
    func getMyPokemons() -> [MyPKMModel]
    func deleteMyPokemon(id: Int)
    func getMyPokemonsData() -> [MyPokemon]
}

class PKMLocaleDataSource: ObservableObject {
    static let sharedInstance = PKMLocaleDataSource()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MyPKMData")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
}

extension PKMLocaleDataSource: PKMLocaleDataSourceProtocol {
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    func save() {
        do {
            try viewContext.save()
            print("The data is saved")
        } catch let error {
            print("Sava data is no completed: \(error.localizedDescription)")
        }
    }
    
    func addMyPokemon(myPkmModel: MyPKMModel) {
        let myPokemon = MyPokemon(context: viewContext)
        myPokemon.id = myPkmModel.id
        myPokemon.name = myPkmModel.name
        myPokemon.fibonancci = String(Helper.fibonancci(editedCount: 0))
        myPokemon.bgColor = myPkmModel.typeColor
        myPokemon.editedCount = "0"
        myPokemon.imgUrl = myPkmModel.imgURL
        
        self.save()
    }
    
    func editMyPokemon(myPokemon: MyPokemon, myPKMModel: MyPKMModel) {
        guard var editedCount: Int = Int(myPokemon.editedCount ?? "0") else { return }
        editedCount += 1
        myPokemon.name = myPKMModel.name
        myPokemon.fibonancci = String(Helper.fibonancci(editedCount: editedCount))
        myPokemon.editedCount = String(editedCount)
        self.save()
    }
    
    func getMyPokemons() -> [MyPKMModel] {
        let request: NSFetchRequest<MyPokemon> = MyPokemon.fetchRequest()
        
        do {
            return try viewContext.fetch(request).map({ myPokemonData in
                MyPKMModel(
                    id: myPokemonData.id ?? "Unknown",
                    name: myPokemonData.name ?? "Unknown",
                    imgURL: myPokemonData.imgUrl ?? "Unknown",
                    fibonancci: myPokemonData.fibonancci ?? "Unknown",
                    typeColor: myPokemonData.bgColor ?? "Unknown",
                    editedCount: Int(myPokemonData.editedCount ?? "0") ?? 0 )
            })
        } catch {
            return []
        }
    }
    
    func deleteMyPokemon(id: Int) {
        guard self.getMyPokemons().count > 1 else { return }
        for myPokemon in self.getMyPokemonsData() {
            let myPKMid = Int(myPokemon.id ?? "0") ?? 0
            if id == myPKMid {
                viewContext.delete(myPokemon)
                save()
                break
            }
        }
    }
    
    func getMyPokemonsData() -> [MyPokemon] {
        let request: NSFetchRequest<MyPokemon> = MyPokemon.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
