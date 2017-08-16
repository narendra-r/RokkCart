//
//  CartManager.swift
//  RokkCart
//
//  Created by Narendra Kumar R on 8/16/17.
//  Copyright © 2017 Tech Vedika. All rights reserved.
//

import Foundation

class CartItem{
    var product: Product?
    var order_quantity: Int = 0
}

class CartManager{
    static let shared = CartManager()
    private init() {}
    
    var cartItems: [CartItem] = []
    
    func addProductToCart(product: Product){
        var orderedItem: CartItem!
        if let existedOrderItem = cartItems.filter({$0.product?.productId == product.productId}).first {
            orderedItem = existedOrderItem
        }else{
            orderedItem = CartItem()
            orderedItem.product = product
            cartItems.append(orderedItem)
        }
        orderedItem.order_quantity += 1
    }
    
    
    var getCartCount: Int {
        var count = 0
        _ = cartItems.map { (item) -> Void in
           count = count + item.order_quantity
        }
        return count
    }
    var getCartPrice: Double {
        var count = 0.0
        _ = cartItems.map { (item) -> Void in
            count = count + (Double(item.order_quantity) * (item.product?.price ?? 0.0))
        }
        return count
    }
    
    func removeItemFromCart(item: CartItem){
        item.product?.availableCount = (item.product?.availableCount ?? 0) + item.order_quantity
        cartItems = cartItems.filter({$0.product?.productId != item.product?.productId})
    }
    
    func decreseProductQuantity(item: CartItem){
        item.order_quantity -= 1
        item.product?.availableCount = (item.product?.availableCount ?? 0) + 1
    }
    
    func increseProductQuantity(item: CartItem){
        item.order_quantity += 1
        item.product?.availableCount = (item.product?.availableCount ?? 0) - 1
    }
    
}
