//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/22.
//

import Foundation

//USER NSDATE FORMATTERS

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale     = Locale(identifier: "ja_JP")
        dateFormatter.timeZone   = .current
        
        return dateFormatter.date(from: self)
        
    }
    
    func convertToDisplayFormat() -> String {
            guard let date = self.convertToDate() else { return "N/A" }
            
            let displayFormatter = DateFormatter()
            displayFormatter.locale = Locale(identifier: "ja_JP")
            displayFormatter.dateFormat = "yyyy年M月d日" // Explicitly adding "年", "月", and "日"
            
            return displayFormatter.string(from: date)
        }
}
