//
//  CartViewController.swift
//  RokkCart
//
//  Created by Narendra Kumar R on 8/16/17.
//  Copyright © 2017 Tech Vedika. All rights reserved.
//

import UIKit

protocol CardUpdationsDelegate {
    func didUpdateCart()
}

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var delegate: CardUpdationsDelegate?
    @IBOutlet weak var totalCartLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTotalCart()
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: CartTableViewCell.ReuseCellIdentifier)
        tableView.estimatedRowHeight = 40
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTotalCart(){
        totalCartLabel.text = "Total cart value : \(CartManager.shared.getCartPrice )"
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.cartItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.ReuseCellIdentifier) as! CartTableViewCell
        cell.selectionStyle = .none
        cell.cartItem = CartManager.shared.cartItems[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension CartViewController: CartCellDelegate{
    func didDelete(item: CartItem) {
        CartManager.shared.removeItemFromCart(item: item)
        tableView.reloadData()
        updateTotalCart()
        delegate?.didUpdateCart()
    }
    func didDecreseProductQuantity(item: CartItem) {
        if item.order_quantity == 1 {
            CartManager.shared.removeItemFromCart(item: item)
        }else {
            CartManager.shared.decreseProductQuantity(item: item)
        }
        tableView.reloadData()
        updateTotalCart()
        delegate?.didUpdateCart()
    }
    func didIncreseProductQuantity(item: CartItem) {
        if item.product?.availableCount == 0 {
            // Can't add more items to cart
        }else{
            CartManager.shared.increseProductQuantity(item: item)
        }
        tableView.reloadData()
        updateTotalCart()
        delegate?.didUpdateCart()

    }
}
