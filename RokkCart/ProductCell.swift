//
//  ProductCell.swift
//  RokkCart
//
//  Created by Narendra Kumar R on 8/16/17.
//  Copyright © 2017 Tech Vedika. All rights reserved.
//

import UIKit

protocol ProductCellDelgate {
    func didBuy(product: Product)
}

class ProductCell: UITableViewCell {

    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var itemsReaminLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    var delegate: ProductCellDelgate?
    static let ReuseCellIdentifier = "ProductCell"

    var product: Product? {
        didSet{
            itemsReaminLabel.text = "Available: \(product?.availableCount ?? 0)"
            productNameLabel.text = "\(product?.name ?? "")"
            if product?.availableCount == 0 {
                buyButton.isEnabled = false
            }else{
                buyButton.isEnabled = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buyAction(_ sender: UIButton) {
        if let product = product {
            delegate?.didBuy(product: product)
        }
    }
    
    
    
}
