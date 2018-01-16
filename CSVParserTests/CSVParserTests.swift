//
//  CSVParserTests.swift
//  CSVParserTests
//
//  Created by Sauvik Dolui on 16/01/18.
//  Copyright © 2018 Innofied Solution Pvt. Ltd. All rights reserved.
//

import XCTest

class CSVParserTests: XCTestCase {
    
    // MARK: Out Custom Test Cases will go here
    func testSingleLineParsing() {
        let line = "One,two,three,4" as Substring
        XCTAssertEqual(parseLine(line), ["One","two","three","4"])
    }
    func testEmptyValueParsing() {
        let line = "One,,two,three,4" as Substring
        XCTAssertEqual(parseLine(line), ["One","","two","three","4"])
    }
    
    func testMultilineLineParsing() {
        let paragraph = "One,,two,three\n4,five"
        let expectedResult = [["One","","two","three"], ["4", "five"]] as [[Substring]]
        let result = parseLines(paragraph)
        XCTAssertEqual(result.first!, expectedResult.first!, "Multiline Parsing Error")
        XCTAssertEqual(result.last!, expectedResult.last!, "Multiline Parsing Error")
    }
    func testCRMultilineLineParsing() {
        let paragraph = "One,,two,three\r\n4,five"
        let expectedResult = [["One","","two","three"], ["4", "five"]] as [[Substring]]
        let result = parseLines(paragraph)
        XCTAssertEqual(result.first!, expectedResult.first!, "Carriage Return Test Failed")
        XCTAssertEqual(result.last!, expectedResult.last!, "Carriage Return Test Failed")
    }
    func testQuoteLineParsing() {
        let paragraph = "One,\"Hi There!\",two,,three\r\n4,five"
        let expectedResult = [["One","\"Hi There!\"","two","","three"], ["4", "five"]] as [[Substring]]
        let result = parseLines(paragraph)
        XCTAssertEqual(result.first!, expectedResult.first!, "Quote Test Failed")
        XCTAssertEqual(result.last!, expectedResult.last!, "Quote Test Failed")
    }
    
    func testQuoteWithCommaLineParsing() {
        let paragraph = "One,\"Hi, There!\",two,,three\r\n4,five"
        let expectedResult = [["One","Hi, There!","two","","three"], ["4", "five"]] as [[Substring]]
        let result = parseLines(paragraph)
        XCTAssertEqual(result.first!, expectedResult.first!, "Quote with Comma Test Failed")
        XCTAssertEqual(result.last!, expectedResult.last!, "Quote with Comma Test Failed")
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

    
}
