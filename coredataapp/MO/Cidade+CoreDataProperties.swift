//
//  Cidade+CoreDataProperties.swift
//  coredataapp
//
//  Created by DocAdmin on 5/2/18.
//  Copyright © 2018 ipvc.estg. All rights reserved.
//

import Foundation
import CoreData


extension Cidade {

    @NSManaged public var nome: String?
    @NSManaged public var populacao: Int16
    @NSManaged public var temPais: Pais?

}
