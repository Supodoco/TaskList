//
//  StorageManager.swift
//  TaskList
//
//  Created by Supodoco on 18.11.2022.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        return container
    }()
    

    func saveContext() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData() -> [Task] {
        let fetchRequest = Task.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    func saveTask(_ taskName: String) -> Task {
        let task = Task(context: persistentContainer.viewContext)
        task.title = taskName
        saveContext()
        return task
    }
    
    func deleteTask(task: Task) {
        persistentContainer.viewContext.delete(task)
        saveContext()
    }
    
    func editTask(task: Task, result: String) {
        task.title = result
        saveContext()
    }
    
}
