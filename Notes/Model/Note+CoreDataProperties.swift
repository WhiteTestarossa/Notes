//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Daniel Belokursky on 26.03.22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID!
    @NSManaged public var text: String!
    @NSManaged public var date: Date!
    
//    convenience init(text: String, entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
//        self.init()
//        self.text = text
//        self.id = UUID()
//        self.date = Date()
//    }

}

extension Note : Identifiable {

}
