//
//  TableViewCell.swift
//  Take My Money
//
//  Created by Jo Albright on 9/25/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

import StoreKit

class TableViewCell: UITableViewCell, SKPaymentTransactionObserver {

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var savedProduct: SKProduct!
    
    var product: SKProduct! {
        
        set(product) {
            
            savedProduct = product
            
            self.nameLabel.text = product.localizedTitle
            self.priceLabel.text = "\(product.priceLocale.objectForKey(NSLocaleCurrencySymbol)!)\(product.price)"
            
        }
        
        get {
            
            return savedProduct
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buyProduct(sender: AnyObject) {
        
        var payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        SKPaymentQueue.defaultQueue().addPayment(payment)
        
    }
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
        
        for transaction in transactions as [SKPaymentTransaction] {
            
            println(transaction.payment.productIdentifier)
            
            switch(transaction.transactionState) {
                
            case SKPaymentTransactionState.Purchased :
                
                println("Purchased")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                
            case SKPaymentTransactionState.Purchasing :
                
                println("Purchasing")
                
            case SKPaymentTransactionState.Deferred :
                
                println("Deferred")
                
            case SKPaymentTransactionState.Restored :
                
                println("Restored")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                
            case SKPaymentTransactionState.Failed :
                
                println("Failed : \(transaction.error)")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)

                
            }
            
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
