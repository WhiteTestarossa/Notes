//
//  CoreDataManager.swift
//  Notes
//
//  Created by Daniel Belokursky on 26.03.22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    //MARK: - Properties
    static let shared = CoreDataManager(modelName: "Notes")
    
    let persistantContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistantContainer.viewContext
    }
    
    //MARK: - Initilizer
    init(modelName: String) {
        self.persistantContainer = NSPersistentContainer(name: modelName)
    }
    
    //MARK: - Core Data Setup
    func load() {
        self.persistantContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

    //MARK: - CRUD Methods
extension CoreDataManager {
    func createNote(text: String = "") -> Note{
        let newNote = Note(context: CoreDataManager.shared.viewContext)
        newNote.id = UUID()
        newNote.text = text
        newNote.date = Date()
        save()
        return newNote
    }
    
    func fetch() -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.date, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        return (try? viewContext.fetch(request)) ?? []
    }
    
    func deleteNote(note: Note) {
        viewContext.delete(note)
        save()
    }
}
