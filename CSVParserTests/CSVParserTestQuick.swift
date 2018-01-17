//
//  CSVParserTestQuick.swift
//  CSVParserTests
//
//  Created by Sauvik Dolui on 16/01/18.
//  Copyright © 2018 Innofied Solution Pvt. Ltd. All rights reserved.
//

import XCTest

import Quick
import Nimble


class CSVParserTestQuick: QuickSpec {
    override func spec() {
        
        describe("Testing parse CSV functions, this can be a set of total test cases on a class") {

            context("Testing Single Line CSV", {
            
                it("Simple CSV Testing", closure: {
                    let line = "One,two,three,4" as Substring
                    expect(try! parseLine(line)).to(equal(["One","two","three","4"]))
                })
                it("Simple CSV Testing with empty value", closure: {
                    let line = "One,two,three,,4" as Substring
                    expect(try! parseLine(line)).to(equal(["One","two","three","", "4"]))
                })
            })
        }
        
    }
    
}
