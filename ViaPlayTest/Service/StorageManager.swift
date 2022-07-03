import CoreData

protocol StorageManagerProtocol {
    func findFirsOrCreate<T: NSManagedObject>(new object: T.Type, by attribute: String, with value: Any) -> T?
    func find<T: NSManagedObject>(type: T.Type) -> [T]
    func saveContext ()
}

final class StorageManager {
    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ViaPlayTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

// MARK: - StorageManagerProtocol

extension StorageManager: StorageManagerProtocol {
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }

    
    func findFirsOrCreate<T: NSManagedObject>(new object: T.Type, by attribute: String, with value: Any) -> T? {
        let context = persistentContainer.viewContext
        let request = T.fetchRequest()
        request.predicate = NSPredicate(format: "\(attribute) == %@", value as! CVarArg)
        let result = try? context.fetch(request)
        var entity = result?.first as? T
        if entity == nil, let entityDescriptor = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: context) {
            entity = NSManagedObject(entity: entityDescriptor, insertInto: context) as? T
        }
        return entity
    }
    
    func find<T: NSManagedObject>(type: T.Type) -> [T] {
        let context = persistentContainer.viewContext
        let request = T.fetchRequest()

        do {
            let result = try context.fetch(request)
            return result as? [T] ?? []
        }catch {
            return []
        }
    }
}
