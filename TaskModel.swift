//
//  TaskModel.swift
//  taskIt
//
//  Created by Martin Brunner on 19.11.14.
//  Copyright (c) 2014 Martin Brunner. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel) // creates an Objective-C bridge

class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var task: String
    @NSManaged var subTask: String

}
