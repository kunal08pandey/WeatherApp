//
//  StorageManager.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 15/07/21.
//

import CoreData

protocol DataManager {
  func addObject<T: NSManagedObject>(_ model: T)
  func instantiate<T: NSManagedObject>(_ type: T.Type) -> NSManagedObject?
  func deleteObject<T: NSManagedObject>(_ model: T)
  func deleteObjects<T: NSManagedObject>(_ type: T.Type)
  func fetch<T: NSManagedObject>(_ type: T.Type) -> [T]
  func saveContext()
}

class StorageManager: DataManager {
  
  init() {
    print("StoreURL\( persistentContainer)")
  }
  
  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
      /*
       The persistent container for the application. This implementation
       creates and returns a container, having loaded the store for the
       application to it. This property is optional since there are legitimate
       error conditions that could cause the creation of the store to fail.
      */
      let container = NSPersistentContainer(name: "WeatherApp")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
               
              /*
               Typical reasons for an error here include:
               * The parent directory does not exist, cannot be created, or disallows writing.
               * The persistent store is not accessible, due to permissions or data protection when the device is locked.
               * The device is out of space.
               * The store could not be migrated to the current model version.
               Check the error message to determine what the actual problem was.
               */
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }

  func addObject<T: NSManagedObject>(_ model: T) {
    persistentContainer.viewContext.insert(model)
    saveContext()
  }
  
  func entity<T: NSManagedObject>(_ type: T.Type) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: T.identifer, in: persistentContainer.viewContext)
  }
  
  func instantiate<T: NSManagedObject>(_ type: T.Type) -> NSManagedObject? {
    guard let entity = entity(type) else { return nil }
    return NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
  }
  
  func deleteObject<T: NSManagedObject>(_ model: T) {
    persistentContainer.viewContext.delete(model)
    saveContext()
  }
  
  func deleteObjects<T: NSManagedObject>(_ type: T.Type) {
    let objects = fetch(type)
    for object in objects {
      persistentContainer.viewContext.delete(object)
      saveContext()
    }
  }
  
  func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: type.identifer)
    do {
      return try persistentContainer.viewContext.fetch(fetchRequest) as! [T]
    } catch {
      debugPrint("Error Occured while fetching \(error)")
      return []
    }
  }
}
