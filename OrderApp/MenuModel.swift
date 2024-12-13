//
//  MenuModel.swift
//  OrderApp
//
//  Created by Elsever on 08.12.24.
//

import Foundation
struct CategoryFood: Codable {
    let categoryName: String?
    let image: String?
    let items: [Items]?
}

struct Items: Codable {
    let itemName: String?
    let image: String?
    let price: Double?
    var units: Int?
}

struct UserInfo: Codable {
    let name: String?
    let email: String?
    let password: String?
}

