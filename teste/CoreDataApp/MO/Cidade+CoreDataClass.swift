//
//  Cidade+CoreDataClass.swift
//  CoreDataApp
//
//  Created by Hugo Pereira on 21/04/18.
//  Copyright © 2018 Hugo Pereira. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Cidade)
public class Cidade: NSManagedObject {

    //MARK: Getters
    static func getAll(appDel: AppDelegate) -> [Cidade]? {
        let dataFetchRequest = NSFetchRequest<Cidade>(entityName: "Cidade")
        var results: [Cidade]
        
        do {
            results = try appDel.persistentContainer.viewContext.fetch(dataFetchRequest)
            return results
            
        }catch{
            
        }
        
        return nil
    }
    
    //get by nome
    
    static func getByNome(nome: String, appDel: AppDelegate) -> Cidade? {
        let dataFetchRequest = NSFetchRequest<Cidade>(entityName: "Cidade")
        let predicate = NSPredicate(format: "nome == %@", nome)
        dataFetchRequest.predicate = predicate
        
        var results: [Cidade]
        
        do {
            results = try appDel.persistentContainer.viewContext.fetch(dataFetchRequest)
            if(results.count > 0){
                return results[0]
            }
        }catch{
        }
        
        return nil
    }
    
    
    
    //MARK: Create
    
    static func insert(nome: String, nomePais: String, populacao: Int16, appDel: AppDelegate){
        let context = appDel.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Cidade", in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        transc.setValue(nome, forKey: "nome")
        transc.setValue(populacao, forKey: "populacao")
        
        let p:Pais = Pais.getByNome(nome: nomePais, appDel: appDel)!
        transc.setValue(p, forKey: "temPais")
        
        do {
            try context.save()
            print("Saved!")
        } catch let error as NSError {
            print("could not save \(error), \(error.userInfo)")
        }
    }
    
    //MARK: Update
    
    static func update(nomeAntigo: String, nomeNovo: String, appDel: AppDelegate){
        let context = appDel.persistentContainer.viewContext
        let dataFetchRequest = NSFetchRequest<Cidade>(entityName: "Cidade")
        let predicate = NSPredicate(format: "nome == %@", nomeAntigo)
        
        dataFetchRequest.predicate = predicate
        
        var results : [Cidade]
        
        do {
            results = try appDel.persistentContainer.viewContext.fetch(dataFetchRequest)
            let cidade = results[0]
            cidade.setValue(nomeNovo, forKey: "nome")
            do {
                try context.save()
            } catch let error as NSError {
                print("Error updating")
            } catch {
            }
        } catch let error as NSError {
            print("could not save \(error), \(error.userInfo)")
        }
    }
    
    //MARK: delete
    
    static func delete(nome: String, appDel: AppDelegate){
        let context = appDel.persistentContainer.viewContext
        let dataFetchRequest = NSFetchRequest<Cidade>(entityName: "Cidade")
        let predicate = NSPredicate(format: "nome == %@", nome)
        
        dataFetchRequest.predicate = predicate
        
        if let result = try? appDel.persistentContainer.viewContext.fetch(dataFetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
    }
}











































