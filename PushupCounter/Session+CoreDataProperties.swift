//
//  Session+CoreDataProperties.swift
//  PushupCounter
//
//  Created by Steve on 05/08/2020.
//  Copyright © 2020 Stepan Pazderka. All rights reserved.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var count: Int32
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?

}
