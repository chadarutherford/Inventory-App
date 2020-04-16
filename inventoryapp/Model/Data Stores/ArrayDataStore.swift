//
//  ArrayDataStore.swift
//  inventoryapp
//
//  Created by Chad Rutherford on 4/16/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

class ArrayDataStore: NSObject, DataStoreProtocol {
	
	var items = [InventoryItem]()
	let days = [25, 30, 35, 40]
	
	@discardableResult override init() {
		items.append(InventoryItem(name: "Highlander", units: 50, manufacturerName: "Toyota"))
		items.append(InventoryItem(name: "Altima", units: 40, manufacturerName: "Nissan"))
		items.append(InventoryItem(name: "Focus", units: 70, manufacturerName: "Ford"))
		items.append(InventoryItem(name: "Impreza", units: 10, manufacturerName: "Subaru"))
	}
	
	func add(item: InventoryItem) {
		items.append(item)
	}
	
	func delete(index: Int) {
		items.remove(at: index)
	}
	
	func getCount() -> Int {
		return items.count
	}
	
	func getItem(index: Int) -> InventoryItem {
		return items[index]
	}
	
	func olderThanDays() -> [InventoryItem] {
		let thirtyDaysAgo = NSCalendar.current.date(byAdding: Calendar.Component.day, value: -PreferenceManager.getDaysOlderThan(), to: Date())
		return items.filter { $0.getDateAdded().compare(thirtyDaysAgo!) == .orderedAscending }
	}
}
