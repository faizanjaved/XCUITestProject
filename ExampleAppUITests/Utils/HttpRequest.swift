//
//  HttpRequest.swift
//  ClubNowUITests
//
//  Created by Syed Faizan Javed on 09/12/2019.
//

import XCTest

class HttpRequest: BasePage{
    let xct = XCTestCase()
    var sut : URLSession!
    
    
    func getRequest(urlString: String, promise: XCTestExpectation) -> Bool {
        sut = URLSession(configuration: .default)
        
        // given
        let url =
                  URL(string: urlString)

        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          // then
          if let error = error {
            XCTFail("Error: \(error.localizedDescription)")
            return
          } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            if statusCode == 200 {
              let responseData = String(data: data!, encoding: String.Encoding.utf8)
              print(responseData)
              // 2
              promise.fulfill()
            } else {
              XCTFail("Status code: \(statusCode)")
            }
          }
        }
        dataTask.resume()
        // 3
        
        xct.wait(for: [promise], timeout: 5)
        sut.invalidateAndCancel()
        return true
    }
    
}
