//
//  Pais+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Hugo Pereira on 21/04/18.
//  Copyright © 2018 Hugo Pereira. All rights reserved.
//
//

import Foundation
import CoreData


extension Pais {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pais> {
        return NSFetchRequest<Pais>(entityName: "Pais")
    }

    @NSManaged public var nome: String?
    @NSManaged public var temCidades: Cidade?

}
