//
//  DateFormatter+Extentions.swift
//  iAppDemo
//
//  Created by Natallia Petrachenka on 24.02.25.
//

import Foundation

extension DateFormatter {

    static let defaultDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

}


