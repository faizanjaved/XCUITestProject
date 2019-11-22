import Foundation
import XCTest

class BaseTest: XCTestCase {
    
    lazy var  app : XCUIApplication = XCUIApplication()
    lazy var datautil = DataUtil()
    lazy var envProps : [String: AnyObject] =  datautil.loadJson("properties")!
    lazy var screenshot = ScreenshotUtil()
        
    /**Base Set Up Method for all Tests**/
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        if(app.exists){
            app.terminate()
        }
        Springboard.deleteMyApp()
        sleep(2)
        app.launch()
    }
    
    
    /**After Test Method**/
    override func tearDown(){
        if(getTestRunStatus() > 0){
          screenshot.saveScreenshot(screenShotName:getScreenShotName())
        }
        app.terminate()
        super.tearDown()
    }
    
    /** This method can be used in any of the tests to print the page source**/
    func printPageSource(){
        print(XCUIApplication().debugDescription)
    }
    
    func getScreenShotName() -> String{
        return self.name.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "-")
    }
    
    func getTestRunStatus() -> Int{
        return Int(self.testRun!.failureCount)
    }
    
    func getValue(dict: [String: AnyObject], key: String) -> String{
        return DataUtil().getValue(dict: dict, key: key)
    }

    func getValueAt(dict: [String: AnyObject], key: String, index: Int) -> String {
        return DataUtil().getValue(dict: dict, key: key)
    }

    func getStringArr(dict: [String: AnyObject], key: String) -> [String]{
        return DataUtil().getStringArr(dict:dict, key:key)
    }
    
    func getApp() -> XCUIApplication {
        return self.app
    }
    
}
