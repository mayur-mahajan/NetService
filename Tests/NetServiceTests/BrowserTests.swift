@testable import NetService
import class XCTest.XCTestCase

import Darwin
import Socket

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

    func netService(_ sender: NetService, didAcceptConnectionWith socket: Socket) {
        print("Did accept connection: \(sender), from: \(socket.remoteHostname)")
        print(try! socket.readString() ?? "")
        try! socket.write(from: "HTTP/1.1 200 OK\r\nContent-Length: 13\r\n\r\nHello, world!")
        socket.close()
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
        print("Publishing service...")
        let delegate = MyServiceDelegate()
        service.delegate = delegate
        service.publish()
        
        sleep(1000)
        print("Stopping service...")
        service.stop()
    }
}
