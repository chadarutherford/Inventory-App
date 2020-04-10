//
//  UserDefaultsMock.swift
//  inventoryappTests
//
//  Created by Chad Rutherford on 4/10/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
@testable import inventoryapp

class UserDefaultsMock: NSObject, UserDefaultsProtocol {
	
	private var dict = [String : Any?]()
	
	deinit {
		dict.removeAll()
	}
	
	func theObject(forKey key: String) -> Any? {
		dict[key] ?? nil
	}
	
	func setTheObject(_ object: Any, forKey key: String) {
		dict[key] = object
	}
	
	func removeTheObject(forKey key: String) {
		dict.removeValue(forKey: key)
	}
	
	func syncronizeAll() {
		
	}
}
