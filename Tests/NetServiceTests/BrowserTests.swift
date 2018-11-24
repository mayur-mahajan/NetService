@testable import NetService
import class XCTest.XCTestCase

import Darwin

class MyServiceDelegate: NetServiceDelegate {
    func netServiceWillPublish(_ sender: NetService) {
        print("Will publish: \(sender)")
    }

    func netServiceDidPublish(_ sender: NetService) {
        print("Did publish: \(sender)")
    }

    func netService(_ sender: NetService, didNotPublish error: Error) {
        print("Did not publish: \(sender), because: \(error)")
    }

    func netServiceDidStop(_ sender: NetService) {
        print("Did stop: \(sender)")
    }
}

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
        let service = NetService(domain: "local.", type: "_karbon._tcp.", name: "publishTest", port: 9876)
        _ = service.setTXTRecord(["id":"6789"])
        print("Publishing service...")
        let delegate = MyServiceDelegate()
        service.delegate = delegate
        service.publish()
        
        for i in 1..<60 {
            print("Sleep 10. iteration \(i)")
            sleep(1)
        }
        print("Stopping service...")
        service.stop()
    }
}
