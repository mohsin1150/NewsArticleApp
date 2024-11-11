//
//  DateFormater.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 11/11/24.
//

import UIKit

func convertDateFormatter(date: String) -> String {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z" // Input date format
    inputDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    inputDateFormatter.locale = Locale(identifier: "en-US")
    
    guard let convertedDate = inputDateFormatter.date(from: date) else {
        // Handle error if the date string cannot be converted
        assertionFailure("Invalid date format")
        return ""
    }
    
    let outputDateFormatter = DateFormatter()
    outputDateFormatter.dateFormat = "MMM d, yyyy" // Desired output date format
    outputDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    return outputDateFormatter.string(from: convertedDate)
}
