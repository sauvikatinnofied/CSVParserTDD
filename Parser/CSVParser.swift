//
//  CSVParser.swift
//  CSVParser
//
//  Created by Sauvik Dolui on 16/01/18.
//  Copyright © 2018 Innofied Solution Pvt. Ltd. All rights reserved.
//

import Foundation
enum ParsingError: Int, Error, Equatable {
    case quoteNotEnded
    case commaNotFoundAfterQuoteNoEmpty
    
    public static func ==(lhs: ParsingError, rhs: ParsingError) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
extension Substring {
    mutating func parseField() throws -> Substring {
        assert(!isEmpty)
        switch self[startIndex] {
        case "\"":
            removeFirst() // Remove the first "
            
            // Lets try to find out the next quote
            guard let nextQuoteIndex = index(of: "\"") else {
                // Next quote not found
                throw ParsingError.quoteNotEnded
            }
            
            let result = prefix(upTo: nextQuoteIndex)
            self = self[index(after: nextQuoteIndex)...] // Cut the result from the line
            if !isEmpty {
                // the first char will be a comma and remove it
                guard removeFirst() == "," else {
                    throw ParsingError.commaNotFoundAfterQuoteNoEmpty
                }
            }
            return result
        default:
            // Line does not start with a quote, lets search for the next comma
            if let nextCommaIndex = index(of:",") {
                // Next comma found
                let result = prefix(upTo: nextCommaIndex)
                self = self[index(after: nextCommaIndex)...] // Upto last after comma
                return result
            } else {
                // Next comma not found, there is not any more value at this line
                let value = self
                removeAll() // Make this line empty
                return value
            }
        }
    }
}
func parseLine(_ line: Substring) throws -> [Substring] {
    
    var reminder = line
    var result: [Substring] = []
    while !reminder.isEmpty {
        try result.append(reminder.parseField())
    }
    return result
}

func parseLines(_ lines: String) throws -> [[Substring]] {
    return try lines.split(whereSeparator: { char in
        switch char {
        case "\n", "\r", "\r\n": return true
        default: return false
        }
    }).map{ line in
        return try parseLine(line as Substring)
    }
}
