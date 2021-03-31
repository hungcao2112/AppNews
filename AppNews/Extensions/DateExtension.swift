//
//  DateExtension.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import Foundation

extension Date {
    
    func toString(format: String? = "dd/MM/YYYY - hh:mm:ss") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
