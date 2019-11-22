//
//  ScreenshotUtil.swift
//  ExampleAppUITests
//
//  Created by Faizan Javed on 06/11/2019.
//

import Foundation
import XCTest
class ScreenshotUtil {
  
  private let screen = XCUIScreen.main
  
  /// Saves the Screenshot as a png image to the folder named "Screenshots" inside the Project folder
  ///
  /// - Parameter screenShotName: The name of the screenshot
  func saveScreenshot(screenShotName: String){
    let fileManager = FileManager.default
    
    let fullscreenshot = screen.screenshot()
    let fileName = getScreenshotFolderPath().appendingPathComponent(screenShotName+".png")
    
    do {
      if fileManager.fileExists(atPath: fileName.absoluteString) {
        try fileManager.removeItem(atPath: fileName.absoluteString)
      }
    }
    catch let error as NSError {
      print("ScreenShot File Error: \(error)")
    }
    try? fullscreenshot.image.pngData()?.write(to: fileName, options: .atomic)
  }
  

    /// Creates the Screenshots folder
    ///
    /// - Returns: returns the path to Screenshots folder
    func getScreenshotFolderPath() -> URL{
    var filePath = ""
    let fileManager = FileManager.default
    var path = Bundle.main.builtInPlugInsPath!
    path.append("/ExampleAppUITests.xctest/Info.plist")
    let dictRoot = NSDictionary(contentsOfFile: path)
    if let dict = dictRoot {
      filePath = dict["ProjectPath"] as! String
    }
    
    let screenshotsDirPath = NSURL(fileURLWithPath:filePath).appendingPathComponent("Screenshots")
    do {
      try fileManager.createDirectory(atPath: screenshotsDirPath!.path, withIntermediateDirectories: true, attributes: nil)
    } catch let error as NSError {
      NSLog("Unable to create the ScreenShots directory \(error.debugDescription)")
    }
    return screenshotsDirPath!
  }
    
}



