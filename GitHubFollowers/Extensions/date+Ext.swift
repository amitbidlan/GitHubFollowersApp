//
//  date+Ext.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/22.
//

import Foundation

extension Date {
    func convertToMonthYearFormat()->String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM yyyy"
        return dateformatter.string(from: self)
    }
}
