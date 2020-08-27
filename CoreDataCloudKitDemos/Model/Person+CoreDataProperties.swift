//
//  Person+CoreDataProperties.swift
//  CoreDataCloudKitDemos
//
//  Created by Rizal Hilman on 28/08/20.
//  Copyright © 2020 Rizal Hilman. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Int64
    @NSManaged public var gender: String?
    @NSManaged public var name: String?

}
