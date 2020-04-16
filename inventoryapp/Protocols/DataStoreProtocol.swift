//
//  DataStoreProtocol.swift
//  inventoryapp
//
//  Created by Chad Rutherford on 4/16/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

protocol DataStoreProtocol {
	func add(item: InventoryItem)
	func delete(index: Int)
	func getCount() -> Int
	func getItem(index: Int) -> InventoryItem
	func olderThanDays() -> [InventoryItem]
}


