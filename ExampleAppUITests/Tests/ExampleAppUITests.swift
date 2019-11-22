import XCTest

class ExampleAppUITests: BaseTest {
    
    func testA_VerifyHelloWorldText() {
        XCTAssertTrue(HomePage().verifyHelloWorldExists())
    }
    
}
