//
//  inventoryappTests.swift
//  inventoryappTests
//
//  Created by Brett Romero on 4/24/17.
//  Copyright © 2017 test. All rights reserved.
//

import XCTest

@testable import inventoryapp

class inventoryappTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if InventoryManager.getCount() != 4 {
            InventoryManager.init()
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        //InventoryManager.items = []
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAddItem() {
        let item = InventoryItem(name: "Rogue", units: 5, manufacturerName: "Nissan")
        InventoryManager.add(item: item)
        
        XCTAssertEqual(InventoryManager.getCount(), 5)
    }
    
    func testAddItem2() {
        let item = InventoryItem(name: "Sentra", units: 5, manufacturerName: "Nissan")
        InventoryManager.add(item: item)
        
        XCTAssertEqual(InventoryManager.getCount(), 5)
    }
    
    func testAddItemVerifyDetails() {
        let item = InventoryItem(name: "Sentra2", units: 4, manufacturerName: "Nissan")
        InventoryManager.add(item: item)
        let newItem = InventoryManager.getItem(index: InventoryManager.getCount()-1)
        
        XCTAssertEqual(newItem.name, "Sentra2")
        XCTAssertEqual(newItem.units, 4)
        XCTAssertEqual(newItem.manufacturerName, "Nissan")
    }
    
    func testAddItem35DaysOldVerifyOlderThan25(){
        InventoryManager.shared.items = []
        let preferenceDays = 25
        PreferenceManager.setDaysOlderThan(days: preferenceDays)
        let itemDays  = 35
        let daysLater = NSCalendar.current.date(byAdding: Calendar.Component.day, //here you can add year, month, hour, etc.
            value: -itemDays, //HEre you can add number of units
             to: Date())
        let item = InventoryItem(name: "Sentra2", units: 4, manufacturerName: "Nissan", date: daysLater!)
        InventoryManager.add(item: item)
        let newitems = InventoryManager.olderThanDays()
        XCTAssertGreaterThanOrEqual(newitems.count, 1, "An item is not older than \(preferenceDays) days")
    }
    
    func testAddItem25DaysOldVerifyNotOlderThan30() {
        InventoryManager.shared.items = []
        let preferenceDays = 30
        PreferenceManager.setDaysOlderThan(days: preferenceDays)
        let itemDays  = 25
        let daysLater = NSCalendar.current.date(byAdding: Calendar.Component.day, //here you can add year, month, hour, etc.
            value: -itemDays, //HEre you can add number of units
            to: Date())
        let item = InventoryItem(name: "Sentra2", units: 4, manufacturerName: "Nissan", date: daysLater!)
        InventoryManager.add(item: item)
        let newitems = InventoryManager.olderThanDays()
        XCTAssertEqual(newitems.count, 0, "An item is older than \(preferenceDays) days")
    }
    
    //START: unit tests
    func testDeleteItem(){
        InventoryManager.delete(index: 0)
        XCTAssertEqual(InventoryManager.getCount(), 3)
    }
    
    func testInitInventoryItem() {
        let item = InventoryItem(name: "Volt", units: 7, manufacturerName: "Chevrolet")
        XCTAssertEqual(item.name, "Volt")
    }
    
    func testCellForRowAt() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as! ViewController
        XCTAssertNotNil(vc.view, "Problem initializing view")
        vc.viewDidLoad()
        let cell = vc.tableView(vc.tableViewMain, cellForRowAt: IndexPath(row:0, section:0)) as! TableViewCell
        XCTAssertEqual(cell.name.text, "Highlander")
    }
    //END: unit tests
}

