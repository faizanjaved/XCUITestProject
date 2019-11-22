import XCTest

class HomePage: BasePage {
    
    lazy var helloWorld_text = text("Hello World")
    
    func verifyHelloWorldExists() -> Bool{
        return helloWorld_text.exists
    }
    
}
