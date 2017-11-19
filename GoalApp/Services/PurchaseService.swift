//
//  PurchaseService.swift
//  GoalApp
//
//  Created by Velkei Miklós on 2017. 11. 18..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import StoreKit

typealias CompletionHandler = (_ success: Bool) -> ()

class PurchaseService: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver{
   
    static let instance = PurchaseService()
    
    //In-App Purchases azonosító
    let IAP_REMOVE_ADS = "com.neonatcore.daily.dose.remove.ads"
    
    //eltárolni az in-appokat
    var productsRequests: SKProductsRequest!
    var products = [SKProduct]()
    var transactionComplete: CompletionHandler?
    
    
    //Appdelegetnél kell meghívni
    func fetchProducts(){
        //Nekem ez az in-app kell
        let productsIds = NSSet(object: IAP_REMOVE_ADS) as! Set<String>
        productsRequests = SKProductsRequest(productIdentifiers: productsIds)
        productsRequests.delegate = self
        productsRequests.start()
    }
    
    func purchaseRemoveAds(onComplete: @escaping CompletionHandler){
        //Mindig ellenőrizni kell, hogy lehet-e fizetni
        if SKPaymentQueue.canMakePayments() && products.count > 0 {
            transactionComplete = onComplete
            //A sorrend amit vissza kapok mindig relatív attól mi van az iTunes-on
            let removeAdsProduct = products[0]
            let payment = SKPayment(product: removeAdsProduct)
            SKPaymentQueue.default().add(self)
            // itt kezdi el a fizetési process-t
            SKPaymentQueue.default().add(payment)
        }else{
            onComplete(false)
        }
    }
    
    func restorePurchase(onComplete: @escaping CompletionHandler){
        if SKPaymentQueue.canMakePayments(){
            transactionComplete = onComplete
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().restoreCompletedTransactions()
        }else{
            onComplete(false)
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0{
            //lekéri az inappokat
            //[<SKProduct: 0x1c0014210>]
            print(response.products.debugDescription)
            products = response.products
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //lehet több eset
        for transaction in transactions{
            switch transaction.transactionState{
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)//kézzel kell elvégezni, mert lehet elbukik valahol ezért kell itt a finish
                if transaction.payment.productIdentifier == IAP_REMOVE_ADS{
                   UserDefaults.standard.set(true, forKey: IAP_REMOVE_ADS)
                    transactionComplete?(true)
                }
                break
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionComplete?(false)
                break
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                if transaction.payment.productIdentifier == IAP_REMOVE_ADS{
                  UserDefaults.standard.set(true, forKey: IAP_REMOVE_ADS)
                    
                }
                transactionComplete?(true)
                break
            default:
                transactionComplete?(false)
                break
            }
            
        }
    }
    

    
    
}
