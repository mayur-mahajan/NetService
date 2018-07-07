@testable import NetService
import class XCTest.XCTestCase

import Darwin

class BrowserTests: XCTestCase {
    static var allTests : [(String, (BrowserTests) -> () throws -> Void)] {
        return [
            ("testBrowse", testBrowse),
        ]
    }
    
    func testBrowse() {
        let browser = NetServiceBrowser()
        browser.searchForServices(ofType: "_ssh._tcp.", inDomain: "local.")
        browser.stop()
    }
    
    func testPublish() {
        let service = NetService(domain: "local.", type: "_http._tcp.", name: "publishTest", port: 9876)
        print("Publishing service...")
        service.publish()
        
        sleep(1000)
        print("Stopping service...")
        service.stop()
    }
}
