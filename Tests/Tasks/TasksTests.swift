//
//  TasksTests.swift
//  Tasks
//
//  Created by Honza Dvorsky on 5/8/16.
//
//

@testable import Tasks
import XCTest

class TasksTests: XCTestCase {

    func testEcho() throws {
        
        let result = try Task.run("echo", "hello world")
        XCTAssertEqual(result.code, 0)
        XCTAssertEqual(result.stderr, "")
        XCTAssertEqual(result.stdout, "hello world")
    }
    
    func testEchoFail() throws {
        
        let result = try Task.run("printf")
        XCTAssertEqual(result.code, 1)
        #if os(Linux)
            let exp = "printf: missing operand\nTry \'printf --help\' for more information."
        #else
            let exp = "usage: printf format [arguments ...]"
        #endif
        XCTAssertEqual(result.stderr, exp)
        XCTAssertEqual(result.stdout, "")
    }
}

extension TasksTests {
    static var allTests: [(String, (TasksTests) -> () throws -> Void)] {
        return [
            ("testEcho", testEcho),
            ("testEchoFail", testEchoFail),
        ]
    }
}
