//
//  Cidade+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Hugo Pereira on 21/04/18.
//  Copyright © 2018 Hugo Pereira. All rights reserved.
//
//

import Foundation
import CoreData


extension Cidade {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cidade> {
        return NSFetchRequest<Cidade>(entityName: "Cidade")
    }

    @NSManaged public var nome: String?
    @NSManaged public var populacao: Int16
    @NSManaged public var temPais: Pais?

}
