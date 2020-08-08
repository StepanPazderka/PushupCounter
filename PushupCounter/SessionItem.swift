//
//  SessionItem.swift
//  PushupCounter
//
//  Created by Steve on 04/08/2020.
//  Copyright © 2020 Stepan Pazderka. All rights reserved.
//

import Foundation
import CoreData

public class SessionItem: NSManagedObject, Identifiable {
    @NSManaged public var date:Date?
    @NSManaged public var count:Int?
}

extension SessionItem {
    
}
