//
//  Formatter.swift
//  Notes
//
//  Created by Daniel Belokursky on 26.03.22.
//

import Foundation

extension Date {
    func format() -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(self) {
            formatter.dateFormat = "HH:mm"
        } else {
            formatter.dateFormat = "dd/MM/yy"
        }
        return formatter.string(from: self)
    }
}
