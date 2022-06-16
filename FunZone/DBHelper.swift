//
//  DBHelper.swift
//  FunZone
//
//  Created by admin on 6/3/22.
//

import Foundation
import UIKit
import CoreData

class DBHelper {
    
    static var dbHelper = DBHelper() //accessible without a DBHelper instance
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext


    //CRUD operations - Deletion
    func deleteNote(title : String) {
        var fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchReq.predicate = NSPredicate(format: "title == %@", title)
        do {
            let note = try context?.fetch(fetchReq)
            context?.delete(note?.first as! Note)
            try context?.save()
            print("Data deleted.")
        } catch {
            print("Error. Data not deleted.")
        }
    }
    
    //CRUD operations - Update
    func updateNote(title: String, body: String) {
        var note = Note()
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.fetchLimit = 1
        do {
            let n = try context?.fetch(fetchRequest)
            if n?.count != 0 {
                note = n?.first as! Note
                note.body = body
                try context?.save()
                print("Data Updated.")
            }
        } catch {
            print("Error")
        }
    }
    
    //CRUD operations - Retrieving
    func getOne(title : String) -> Note { //get one student with name
        var note = Note()
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.fetchLimit = 1 //to fetch only the first item with the parameter "name"
        do {
            let request = try context?.fetch(fetchRequest) as! [Note]
            if request.count != 0 {
                note = request.first as! Note
            } else {
                print("Error: No notes found.")
            }
        } catch {
            print("Error.")
        }
        return note
    }
    
    func checkTitle(title : String) -> Bool { //get one student with name
        var isTitleCreated = false
        var note = Note()
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.fetchLimit = 1 //to fetch only the first item with the parameter "name"
        do {
            let request = try context?.fetch(fetchRequest) as! [Note]
            if request.count != 0 {
                isTitleCreated = true
                note = request.first as! Note
            } else {
                isTitleCreated = false
                print("Error: No notes found.")
            }
        } catch {
            print("Error.")
        }
        return isTitleCreated
    }
    
    //CRUD operations - Creation
    func addData (titleValue : String, bodyValue: String) {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context!) as! Note
        note.title = titleValue
        note.body = bodyValue
        do {
            try context?.save()
            print("Note data saved.")
        } catch {
            print("Error: Data not saved.")
        }
    }
    
}

