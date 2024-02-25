//
//  DateExt.swift
//  Soccer
//
//  Created by Дмитрий Терехин on 07.06.2023.
//
import UIKit

extension Date {
    
    func toString(_ withFormat: String = "dd.MM.yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        return dateFormatter.string(from: self)
    }
    
    func toYears() -> Int {
        let calendar = Calendar.current
        let date2 = calendar.startOfDay(for: Date())
        let components = calendar.dateComponents([.year], from: self, to: date2)
        return components.year ?? 0
    }
    
}
