//
//  LocalDatabase.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//

import Foundation
import CoreData

struct LocalDatabase {
    private static var context: NSManagedObjectContext?
    
    static func initialize(){
        if context == nil {
            let container = NSPersistentContainer(name: "AppDatabase")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            context = container.viewContext
        }
    }
    
    static func getAllPosts(_ searchText: String) -> [Post] {
        initialize()
        do {
            let request = Post.fetchRequest() as NSFetchRequest<Post>
            if !searchText.lowercased().trimmingCharacters(in: .whitespaces).isEmpty {
                let pred = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
                request.predicate = pred
            }
            let data = try context?.fetch(request)
            return data ?? [Post]()
        } catch  {
            // error
        }
        return [Post]()
    }
    
    static func createPost(_ id: Int, _ title: String, _ body: String) {
        initialize()
        let newData = Post(context: context!)
        newData.userId = 1
        newData.id = Int32(id)
        newData.title = title
        newData.body = body
        
        do {
            try context?.save()
        } catch {
            // error
        }
    }
}
