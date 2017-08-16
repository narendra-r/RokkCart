//
//  Product.swift
//  RokkCart
//
//  Created by Narendra Kumar R on 8/16/17.
//  Copyright © 2017 Tech Vedika. All rights reserved.
//

import Foundation

class Product{
    var name: String?
    var price: Double?
    var availableCount: Int?
    var productId : Int?
    
    init(item: [String:Any]) {
        self.productId = item["id"] as? Int
        self.name = item["name"] as? String
        self.price = item["price"] as? Double
        self.availableCount = item["available_count"] as? Int
    }
}
