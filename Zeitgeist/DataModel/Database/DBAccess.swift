import CoreData
import Foundation
import UIKit

class DBAccess {
    static let shared = DBAccess()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        return getPersistentContainer()
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {}
    
    // --------------------------------------------------------------------------------
    
    func save() {
        guard context.hasChanges else {
            return
        }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    // --------------------------------------------------------------------------------
    // Mark - Records

    func getToday() -> Record? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        request.predicate = Predicates.filterDay(forDate: Date(), attribute: "begin")
        
        do {
            let records = try context.fetch(request) as? [Record]
            guard let rec = records, rec.count == 1 else {
                return nil
            }
            return rec[0]
        } catch {
            fatalError("Failed to fetch Groups: \(error)")
            // return [Group]()
        }
    }
    
    func getRecords() -> [Record] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")

        do {
            return try context.fetch(request) as! [Record]
        } catch {
            fatalError("Failed to fetch Groups: \(error)")
            // return [Record]()
        }
    }

    func getRecords(forMonth month: Date) -> [Record] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        request.predicate = Predicates.filterMonth(forDate: month, attribute: "begin")

        do {
            return try context.fetch(request) as! [Record]
        } catch {
            fatalError("Failed to fetch Groups: \(error)")
            // return [Group]()
        }
    }

    func createRecord() -> Record {
        let rec = Record(context: context)
        rec.begin = Date()
        return rec
    }
}

// Mark - Load Store
extension DBAccess
{
    private func getPersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "Zeitgeist")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
    }
}
