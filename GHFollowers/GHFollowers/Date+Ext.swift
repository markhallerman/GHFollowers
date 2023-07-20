//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Mark on 8/23/21.
//

import Foundation

extension Date: RawRepresentable {

    private static let formatter = ISO8601DateFormatter()


    public var rawValue: String {
        Date.formatter.string(from: self)
    }


    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }


    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"

        return dateFormatter.string(from: self)
    }
}
