//
//  CoreDataHandler.swift
//  SwiftStorage
//
//  Created by new on 29/05/18.
//  Copyright © 2018 yuvraj. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler{
    
    private func getContext() -> NSManagedObjectContext {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        return appdelegate.persistentContainer.viewContext
    }
    
    func createNotes(helper : NotesHelper){
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(helper.photo, forKey: "image")
        managedObject.setValue(helper.content, forKey: "content")
        managedObject.setValue(helper.location.location, forKey: "location")
        managedObject.setValue(helper.location.lattitude, forKey: "lattitude")
        managedObject.setValue(helper.location.longitude, forKey: "longitude")
        
        do {
            try context.save()
        } catch  {
            print("Error creating notes")
        }
    }
    
    func getNotesList() -> [Notes] {
        let context = getContext()
        var notes : [Notes]? = nil
        do {
            notes = try context.fetch(Notes.fetchRequest())
        } catch {
            print(error)
        }
         return notes!
    }
}
