//
//  CoreDataStore.swift
//  inventoryapp
//
//  Created by Chad Rutherford on 4/16/20.
//  Copyright © 2020 test. All rights reserved.
//

import CoreData
import UIKit

class CoreDataStore: DataStoreProtocol {
	
	var appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
	var managedObjectContext: NSManagedObjectContext
	var items: [InventoryItem]
	
	init() {
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
	
	func add(item: InventoryItem) {
		do {
			items.append(item)
			try managedObjectContext.save()
		} catch let error as NSError {
			print("Failed to save an item: \(error)")
		}
	}
	
	func delete(index: Int) {
		items.remove(at: index)
		do {
			try managedObjectContext.save()
		} catch let error as NSError {
			fatalError("Failed to delete item at \(index): \(error) ")
		}
	}
	
	func getCount() -> Int {
		return items.count
	}
	
	func getItem(index: Int) -> InventoryItem {
		return items[index]
	}
	
	func clear() {
		items = []
		do {
			try managedObjectContext.save()
		} catch {
			fatalError("Failed to clear items: \(error)")
		}
	}
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<InventoryItem> {
		return NSFetchRequest<InventoryItem>(entityName: InventoryManager.entityName)
	}
	
	func olderThanDays() -> [InventoryItem] {
		let thirtyDaysAgo = NSCalendar.current.date(byAdding: Calendar.Component.day, value: -PreferenceManager.getDaysOlderThan(), to: Date())
		return items.filter { $0.getDateAdded().compare(thirtyDaysAgo!) == .orderedAscending }
	}
}
