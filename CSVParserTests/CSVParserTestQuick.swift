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
            
            context("Testing Multi Line Line CSV", {
                it("Must be able to parse multiline csv") {
                    let paragraph = "One,,two,three\n4,five"
                    let expectedResult = [["One","","two","three"], ["4", "five"]] as [[Substring]]
                    let result = try! parseLines(paragraph)
                    expect(result.first!).to(equal(expectedResult.first!))
                    expect(result.last!).to(equal(expectedResult.last!))
                }
                it("Must be able to parse multiline csv with Line Feed and Carriage return") {
                    let paragraph = "One,,two,three\r\n4,five"
                    let expectedResult = [["One","","two","three"], ["4", "five"]] as [[Substring]]
                    let result = try! parseLines(paragraph)
                    expect(result.first!).to(equal(expectedResult.first!))
                    expect(result.last!).to(equal(expectedResult.last!))
                }
            })
            
            context("Testing Quotes in CSV", {
                
                it("Must be able to parse quote on the values") {
                    let paragraph = "One,\"Hi There!\",two,,three\r\n4,five"
                    let expectedResult = [["One","Hi There!","two","","three"], ["4", "five"]] as [[Substring]]
                    let result = try! parseLines(paragraph)
                    expect(result.first!).to(equal(expectedResult.first!))
                    expect(result.last!).to(equal(expectedResult.last!))
                }
                it("Must be able to parse quote with comma on the values") {
                    let paragraph = "One,\"Hi, There!\",two,,three\r\n4,five"
                    let expectedResult = [["One","Hi, There!","two","","three"], ["4", "five"]] as [[Substring]]
                    let result = try! parseLines(paragraph)
                    expect(result.first!).to(equal(expectedResult.first!))
                    expect(result.last!).to(equal(expectedResult.last!))
                }
            })
            
            context("Must be able to handle errors", {
                it("Must be able to detect the InvalidCSVQuoteNotEnding Error") {
                    let paragraph = "One,\"Hi, There!,two,,three\r\n4,five"
                    do {
                        let _ = try parseLines(paragraph)
                        let _ = expect(fail())
                    } catch let error as ParsingError {
                        expect(error).to(equal(ParsingError.quoteNotEnded))
                    } catch {
                        let _ = expect(fail())
                    }
                }
                
                it("Must be able to detect the InvalidCSVQuoteNotEnding Error") {
                    let paragraph = "One,\"Hi, There!\"two,three\r\n4,five"
                    do {
                        let _ = try parseLines(paragraph)
                        let _ = expect(fail())
                    } catch let error as ParsingError {
                        expect(error).to(equal(ParsingError.commaNotFoundAfterQuoteNoEmpty))
                    } catch {
                        let _ = expect(fail())
                    }
                }
            })
        }
        
    }
    
}
