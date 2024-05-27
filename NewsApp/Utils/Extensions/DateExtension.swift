//
//  DateExtension.swift
//  NewsApp
//
//  Created by Vitor Boff on 27/05/24.
//

import Foundation

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var twoDaysAgo: Date { return Date().twoDaysBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var twoDaysBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}
