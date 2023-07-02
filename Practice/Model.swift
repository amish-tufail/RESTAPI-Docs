//
//  Model.swift
//  Practice
//
//  Created by Amish on 02/07/2023.
//

import Foundation


struct Model: Identifiable, Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
