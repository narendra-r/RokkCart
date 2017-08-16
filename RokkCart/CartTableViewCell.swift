//
//  CartTableViewCell.swift
//  RokkCart
//
//  Created by Narendra Kumar R on 8/16/17.
//  Copyright © 2017 Tech Vedika. All rights reserved.
//

import UIKit


protocol CartCellDelegate {
    func didDelete(item: CartItem)
    func didIncreseProductQuantity(item: CartItem)
    func didDecreseProductQuantity(item: CartItem)
}

class CartTableViewCell: UITableViewCell {
    static let ReuseCellIdentifier = "CartTableViewCell"

    @IBOutlet weak var cartItemNameLabel: UILabel!
    @IBOutlet weak var productOrderNumberLabel: UILabel!

    var delegate: CartCellDelegate?
    
    
    
    var cartItem: CartItem? {
        didSet{
            cartItemNameLabel.text = cartItem?.product?.name
            productOrderNumberLabel.text = "\(cartItem?.order_quantity ?? 0) * \(cartItem?.product?.price ?? 0) = \((Double(cartItem?.order_quantity ?? 0)) * (cartItem?.product?.price ?? 0))"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func didDeleteItem(_ sender: UIButton) {
        if let item = cartItem {
            delegate?.didDelete(item: item)
        }
    }
    
    @IBAction func increseCartOrderItems(_ sender: UIButton) {
        if let item = cartItem {
            delegate?.didIncreseProductQuantity(item: item)
        }
    }
    
    @IBAction func decreseCartOrderItems(_ sender: UIButton) {
        if let item = cartItem {
            delegate?.didDecreseProductQuantity(item: item)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
