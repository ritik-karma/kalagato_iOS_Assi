//
//  Task.swift
//  kalagato_iOS_Assi
//
//  Created by Ritik Karma on 11/03/25.
//

import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var details: String
    var isCompleted: Bool = false
}
