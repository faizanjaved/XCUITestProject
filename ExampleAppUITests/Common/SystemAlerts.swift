import Foundation
import XCTest


final class SystemAlerts{
    
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    /// Method to accept System Alerts
    func acceptNotification(buttonName:String){
         let button = springboard.buttons[buttonName]
        let okBtn = springboard.buttons["OK"]
        let exists = NSPredicate(format:"enabled == true")
        
        let expectBtns = [
            XCTestCase().expectation(for: exists, evaluatedWith: button, handler: nil),
            XCTestCase().expectation(for: exists, evaluatedWith: okBtn, handler: nil)
        ]
        
        if(button.exists) {
        button.click()
        }
        _ = expectBtns.map { $0.fulfill() }
    }
    
}
