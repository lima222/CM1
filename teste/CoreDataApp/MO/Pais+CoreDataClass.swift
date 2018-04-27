//
//  Pais+CoreDataClass.swift
//  CoreDataApp
//
//  Created by Hugo Pereira on 21/04/18.
//  Copyright © 2018 Hugo Pereira. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Pais)
public class Pais: NSManagedObject {

    //MARK: Getters
    static func getAll(appDel: AppDelegate) -> [Pais]? {
        let dataFetchRequest = NSFetchRequest<Pais>(entityName: "Pais")
        var results: [Pais]
        
        do {
            results = try appDel.persistentContainer.viewContext.fetch(dataFetchRequest)
            return results
            
        }catch{
            
        }
        
        return nil
    }
    
    //get by nome
    
    static func getByNome(nome: String, appDel: AppDelegate) -> Pais? {
        let dataFetchRequest = NSFetchRequest<Pais>(entityName: "Pais")
        let predicate = NSPredicate(format: "nome == %@", nome)
        dataFetchRequest.predicate = predicate
        
        var results: [Pais]
        
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
    
    static func insert(nome: String, appDel: AppDelegate){
        let context = appDel.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Pais", in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        transc.setValue(nome, forKey: "nome")
        
        do {
            try context.save()
            print("Saved!")
        } catch let error as NSError {
            print("could not save \(error), \(error.userInfo)")
        }
    }
    
    
    //MARK: put/update
    
    static func update(nomeAntigo: String, nomeNovo: String, appDel: AppDelegate){
        let context = appDel.persistentContainer.viewContext
        let dataFetchRequest = NSFetchRequest<Pais>(entityName: "Pais")
        let predicate = NSPredicate(format: "nome == %@", nomeAntigo)
        dataFetchRequest.predicate = predicate
        
        var results: [Pais]
        
        do {
            results = try appDel.persistentContainer.viewContext.fetch(dataFetchRequest)
            let pais = results[0]
            pais.setValue(nomeNovo, forKey: "nome")
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not update")
            } catch{
                
            }
            
        } catch  {
            print("Error updating")
        }
    }
    
    
    //MARK: delete
    
    static func delete(nome: String, appDel: AppDelegate){
        let context = appDel.persistentContainer.viewContext
        let dataFetchRequest = NSFetchRequest<Pais>(entityName: "Pais")
        let predicate = NSPredicate(format: "nome == %@", nome)
        
        dataFetchRequest.predicate = predicate
        
        if let result = try? appDel.persistentContainer.viewContext.fetch(dataFetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
    }
}






































































































































