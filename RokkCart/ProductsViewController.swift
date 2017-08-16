//
//  ViewController.swift
//  RokkCart
//
//  Created by Narendra Kumar R on 8/16/17.
//  Copyright © 2017 Tech Vedika. All rights reserved.
//

import UIKit


class ProductsViewController: UIViewController {

    
    @IBOutlet weak var cartButton: UIButton!
    var products:[Product] = []
    
    @IBOutlet weak var totalCartAmount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: ProductCell.ReuseCellIdentifier)
        tableView.estimatedRowHeight = 40
        self.applyViewChanges()
        self.readProducts()
        
    }
    
    func applyViewChanges(){
        cartButton.layer.cornerRadius = cartButton.frame.width/2
        cartButton.layer.masksToBounds = true
    }
    
    func readProducts(){
        
        guard let productObject = self.loadJSON(),
            let items = productObject["items"] as? [[String:Any]] else {
            //error no items found
            return
        }
        
        items.forEach { (item) in
            let product = Product.init(item: item)
            self.products.append(product)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cartAction(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CartViewController
        destination.delegate = self
    }
    
    func loadJSON() -> [String:Any]?{
        if let path = Bundle.main.path(forResource: "products", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                    return jsonResult
                    
                } catch {}
            } catch {}
        }
        return nil
    }
    
    func updateCartCount(){
        cartButton.setTitle("\(CartManager.shared.getCartCount)", for: .normal)
        totalCartAmount.text = "Total Cart amount: \(CartManager.shared.getCartPrice)"
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.ReuseCellIdentifier) as! ProductCell
        cell.product = products[indexPath.row]
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ProductsViewController: ProductCellDelgate{
    func didBuy(product: Product) {
        CartManager.shared.addProductToCart(product: product)
        product.availableCount = (product.availableCount ?? 0) - 1
        tableView.reloadData()
        updateCartCount()
    }
}

extension ProductsViewController: CardUpdationsDelegate{
    func didUpdateCart() {
        updateCartCount()
        tableView.reloadData()
    }
}

