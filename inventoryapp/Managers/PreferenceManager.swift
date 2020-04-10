//
//  PreferenceManager.swift
//  inventoryapp
//

import Foundation

class PreferenceManager: NSObject {
    private static var fontSize:Int = 8
    private static var userDefaults = UserDefaults.standard
    private static var daysOlderThan = 30
    
    static func setFontSize(fontSize:Int) {
        PreferenceManager.fontSize = fontSize
        PreferenceManager.userDefaults.set(fontSize, forKey: "fontSize")
    }
    
    static func getFontSize() -> Int {
        if let fontSize = PreferenceManager.userDefaults.object(forKey: "fontSize") {
            return fontSize as! Int
        }
        return PreferenceManager.fontSize
    }
    
    static func setDaysOlderThan(days:Int){
        PreferenceManager.daysOlderThan = days
        PreferenceManager.userDefaults.set(days, forKey: "daysOlderThan")
    }
    
    static func getDaysOlderThan() -> Int{
        if let daysOlder = PreferenceManager.userDefaults.object(forKey: "daysOlderThan") {
            return daysOlder as! Int
        }
        return PreferenceManager.daysOlderThan
    }
}
