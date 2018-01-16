//
//  CSVParser.swift
//  CSVParser
//
//  Created by Sauvik Dolui on 16/01/18.
//  Copyright © 2018 Innofied Solution Pvt. Ltd. All rights reserved.
//

import Foundation

func parseLine(line: Substring) -> [Substring] {
    return line.split(separator: ",", maxSplits: Int.max, omittingEmptySubsequences: false)
}
func parseLines(lines: String) -> [[Substring]] {
    return lines.split(whereSeparator: { char in
        switch char {
        case "\n", "\r", "\r\n": return true
        default: return false
        }
    }).map{ line in
        return parseLine(line: line as Substring)
    }
}
