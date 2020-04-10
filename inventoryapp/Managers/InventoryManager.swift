//
//  InventoryManager.swift
//  inventoryapp
//
//  Created by Brett Romero on 12/27/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit
import CoreData

class InventoryManager: NSObject {

    static let entityName = "InventoryItem"
    static var shared:InventoryManager = InventoryManager()
    static let days = [25,30,35,40]

    var appDelegate:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
    var managedObjectContext:NSManagedObjectContext
    var items:[InventoryItem]
    
    @discardableResult override init(){
        managedObjectContext = appDelegate.persistentContainer.viewContext
        let itemsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: InventoryManager.entityName)
        itemsFetch.sortDescriptors = [
            NSSortDescriptor(key: "manufacturerName", ascending: true)
        ]
        do {
            items = try managedObjectContext.fetch(itemsFetch) as! [InventoryItem]
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    static func add(item: InventoryItem) {
        do {
            shared.items.append(item)
            try shared.managedObjectContext.save()
        } catch let error as NSError {
            print("Failed to save an item", error)
        }
    }
    
    static func delete(index: Int) {
        shared.managedObjectContext.delete(InventoryManager.getItem(index: index))
        shared.items.remove(at: index)
        do {
            try shared.managedObjectContext.save()
        } catch {
            fatalError("delete(): Error deleting item \(index)")
        }
    }
    
    static func getCount() -> Int {
        return shared.items.count
    }
    
    static func getItem(index: Int) -> InventoryItem {
        return shared.items[index]
    }
    
    static func olderThanDays() -> [InventoryItem]{
        let thirtyDaysAgo = NSCalendar.current.date(byAdding: Calendar.Component.day, //Here you can add year, month, hour, etc.
            value: -PreferenceManager.getDaysOlderThan(),  //Here you can add number of units
            to: Date())
        //return collection of items older than 30 days.
        return shared.items.filter({  $0.getDateAdded().compare(thirtyDaysAgo!) == .orderedAscending })
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<InventoryItem> {
        return NSFetchRequest<InventoryItem>(entityName: InventoryManager.entityName)
    }
}



class DetermineImageURL {
    func setImageURL(item: InventoryItem) {
        switch item.manufacturerName {
        case "Ford"?:
            item.logoUrl = "http://www.bitesizebschool.com/pluralsight_mocksstubs/fordlogo.png"
        case "Chevy"?:
            item.logoUrl = "http://www.bitesizebschool.com/pluralsight_mocksstubs/chevylogo.png"
        case "Toyota"?:
            item.logoUrl = "http://www.bitesizebschool.com/pluralsight_mocksstubs/toyotalogo.png"
        default:
            item.logoUrl = ""
        }
    }
}
