//
//  UserDefaultsProtocol.swift
//  inventoryapp
//
//  Created by Chad Rutherford on 4/10/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {
	func theObject(forKey key: String) -> Any?
	func setTheObject(_ object: Any, forKey key: String)
	func removeTheObject(forKey key: String)
	func syncronizeAll()
}

extension UserDefaults: UserDefaultsProtocol {
	func theObject(forKey key: String) -> Any? {
		self.object(forKey: key)
	}
	
	func setTheObject(_ object: Any, forKey key: String) {
		self.set(object, forKey: key)
	}
	
	func removeTheObject(forKey key: String) {
		self.removeObject(forKey: key)
	}
	
	func syncronizeAll() {
		self.synchronize()
	}
}
